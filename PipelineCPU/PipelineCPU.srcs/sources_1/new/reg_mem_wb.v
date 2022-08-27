`timescale 1ns / 1ps

module reg_mem_wb(
    input   wire        clk,
    input   wire        rst,
    
    input   wire        mem_reg_write,
    input   wire        mem_mem2reg,
    input   wire[31:0]  mem_alu_out,
    input   wire[31:0]  mem_mem_rd,
    input   wire[31:0]  mem_reg_wa,
    
    output  reg         wb_reg_write,
    output  reg         wb_mem2reg,
    output  reg[31:0]   wb_alu_out,
    output  reg[31:0]   wb_mem_rd,
    output  reg[31:0]   wb_reg_wa
    );
endmodule
