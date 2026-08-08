`timescale 1ns / 1ps

module volt_display(
    input wire clk_100m,       // 100MHz 系统时钟
    input wire sw0,            // SW0 显示控制开关 (1:显示, 0:不显示)
    input wire [15:0] adc_data,// 来自 XADC 的采样数据
    output reg [3:0] an,       // 数码管片选 (高电平有效)
    output reg [7:0] seg       // 数码管段选 (包含小数点，高电平有效)
);

    reg [26:0] update_cnt = 0;
    reg [15:0] stable_adc_data = 0;

    always @(posedge clk_100m) begin
        if (update_cnt == 27'd50_000_000) begin
            update_cnt <= 0;
            stable_adc_data <= adc_data; // 每隔  秒，抓取一次当前电压
        end else begin
            update_cnt <= update_cnt + 1;
        end
    end


    // XADC的数据是16位的，但有效位是高12位 [15:4]
    wire [11:0] valid_adc = stable_adc_data[15:4];
    // XADC的数据是16位的，但有效位是高12位 [15:4]
    
    // 将ADC值映射到0-1000mV (1V = 1000mV)
    // 计算公式: mV = (ADC_VAL / 4096) * 1000
    wire [31:0] voltage_mv = (valid_adc * 1000) >> 12;

    // 提取个位、十位、百位、千位 (对应数码管的4个位置)
    // mV 个位
    // mV 十位
    // mV 百位
    // V 单次位
wire [3:0] digit_0 = (voltage_mv / 1000) % 10;        
wire [3:0] digit_1 = (voltage_mv / 100) % 10;   
wire [3:0] digit_2 = (voltage_mv / 10) % 10;  
wire [3:0] digit_3 =voltage_mv % 10;
 //  wire [3:0] digit_0 = 4'd1;
  // wire [3:0] digit_1 = 4'd2;
  // wire [3:0] digit_2 = 4'd3;
  // wire [3:0] digit_3 = 4'd4;
    // 数码管动态扫描分频器 (约 1KHz 刷新率)
    reg [16:0] scan_cnt = 0;
    always @(posedge clk_100m) begin
        scan_cnt <= scan_cnt + 1;
    end
    wire [1:0] scan_sel = scan_cnt[16:15];

    // 当前需要显示的BCD码
    reg [3:0] current_digit;
    // 当前小数点控制 (1为点亮)
    reg dp; 


    always @(*) begin
        an = 4'b0000;
        current_digit = 4'b0000;
        dp = 1'b0;

        if (sw0) begin
            case(scan_sel)
                2'b00: begin an = 4'b0001; current_digit = digit_3; dp = 1'b0; end //  digit_3 
                2'b01: begin an = 4'b0010; current_digit = digit_2; dp = 1'b0; end //  digit_2 
                2'b10: begin an = 4'b0100; current_digit = digit_1; dp = 1'b0; end //  digit_1 
                2'b11: begin an = 4'b1000; current_digit = digit_0; dp = 1'b1; end //  digit_0 
                default: begin an = 4'b0000; current_digit = 4'b0000; dp = 1'b0; end
            endcase
            
            if (scan_cnt[14:8] == 7'b0000000) begin
                an = 4'b0000; // 熄灭片选，等待段选信号彻底稳定
            end
        end
    end

    // BCD 到 七段数码管解码 (共阴极/高电平有效)
    // 编码顺序: DP, G, F, E, D, C, B, A
    always @(*) begin
        if (!sw0) begin
            seg = 8'h00; // 熄灭输出低电平
        end else begin
            case(current_digit)
                4'd0: seg = {dp, 7'b0111111};
                4'd1: seg = {dp, 7'b0000110};
                4'd2: seg = {dp, 7'b1011011};
                4'd3: seg = {dp, 7'b1001111};
                4'd4: seg = {dp, 7'b1100110};
                4'd5: seg = {dp, 7'b1101101};
                4'd6: seg = {dp, 7'b1111101};
                4'd7: seg = {dp, 7'b0000111};
                4'd8: seg = {dp, 7'b1111111};
                4'd9: seg = {dp, 7'b1101111};
                default: seg = 8'h00;
            endcase
        end
    end

endmodule
