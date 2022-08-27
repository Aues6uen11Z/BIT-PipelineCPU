`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  reg_ra1,    //读地址
    input   wire[31:0]  reg_ra2,
    input   wire        reg_we,     //写使能
    input   wire[31:0]  reg_wa,     //写地址
    input   wire[31:0]  reg_wd,     //待写数据
    
    output  reg[31:0]   reg_rd1,    //读出数据
    output  reg[31:0]   reg_rd2
    );
endmodule
