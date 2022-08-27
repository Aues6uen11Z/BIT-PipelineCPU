`timescale 1ns / 1ps

module reg_id_ex(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[1:0]   id_branch,
    input   wire        id_reg_write,
    input   wire        id_alu_src,
    input   wire[3:0]   id_alu_op,
    input   wire        id_mem_write,
    input   wire        id_mem2reg,
    input   wire[31:0]  id_rd1,
    input   wire[31:0]  id_rd2,
    input   wire[31:0]  id_reg_wa,
    input   wire[31:0]  id_imm,
    input   wire[31:0]  id_pc,
    
    output  reg[1:0]    ex_branch,
    output  reg         ex_reg_write,
    output  reg         ex_alu_src,
    output  reg[3:0]    ex_alu_op,
    output  reg         ex_mem_write,
    output  reg         ex_mem2reg,
    output  reg[31:0]   ex_rd1,
    output  reg[31:0]   ex_rd2,
    output  reg[31:0]   ex_reg_wa,
    output  reg[31:0]   ex_imm,
    output  reg[31:0]   ex_pc
    );
endmodule
