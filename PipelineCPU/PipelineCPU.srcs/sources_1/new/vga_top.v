`timescale 1ns / 1ps

module vga_top(
    input   wire        clk,
    input   wire        rstn,
    input   wire[31:0]  vga_pos,
    
    output  wire        hsync,
    output  wire        vsync,
    output  wire[3:0]   red,
    output  wire[3:0]   green,
    output  wire[3:0]   blue
    );
    
    wire clk_vga;
    clk_change _clk_change(
        .clk_out1(clk_vga),
        .reset(~rstn),
        .clk_in1(clk)
    );
    
    display _display(
        .clk(clk_vga),
        .rstn(rstn),
        .vga_pos(vga_pos),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );
endmodule
