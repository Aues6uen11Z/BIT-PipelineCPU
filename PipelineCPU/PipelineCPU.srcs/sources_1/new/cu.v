`timescale 1ns / 1ps
`include "macro.vh"

module cu(
    input   wire        rst,
    
    input   wire[5:0]   cu_opcode,
    input   wire[5:0]   cu_func,
    
    output  reg[1:0]    cu_branch,      //分支指令信号
    output  reg         cu_reg_dst,     //寄存器写入地址
    output  reg         cu_reg_write,   //寄存器写使能
    output  reg         cu_alu_src,     //ALU操作数来源
    output  reg[3:0]    cu_alu_op,      //ALU操作码
    output  reg         cu_mem_write,   //数据存储器写使能
    output  reg         cu_mem2reg,     //寄存器写回来源
    output  reg         cu_sign_ext     //立即数位数扩展
    );
endmodule
