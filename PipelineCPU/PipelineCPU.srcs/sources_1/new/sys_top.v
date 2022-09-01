`timescale 1ns / 1ps

module sys_top(
    input   wire        clk,
    input   wire        rstn,
    input   wire        btn_left,
    input   wire        btn_right,
    input   wire        btn_up,
    input   wire        btn_down,
    
    output   wire       hsync,      // 行同步信号
    output   wire       vsync,      // 场同步信号
    output   wire[3:0]  red,        // 红色输出信号
    output   wire[3:0]  green,      // 绿色输出信号
    output   wire[3:0]  blue        // 蓝色输出信号
    );

wire vga_en;
wire[1:0] vga_dir;
wire[31:0] vga_pos;
assign vga_en = (btn_left || btn_right || btn_up || btn_down) ? 1'b1 : 1'b0;
assign vga_dir = btn_left ? 2'b00 :
                btn_right ? 2'b01 :
                btn_up ? 2'b10 :
                2'b11;

cpu_top _cpu_top(
    .clk(clk),
    .rstn(rstn),
    .vga_en(vga_en),
    .vga_dir(vga_dir),
    .vga_pos(vga_pos)
);

vga_top _vga_top(
    .clk(clk),
    .rstn(rstn),
    .vga_pos(vga_pos),
    .hsync(hsync),
    .vsync(vsync),
    .red(red),
    .green(green),
    .blue(blue)
);
endmodule
