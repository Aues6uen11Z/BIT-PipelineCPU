`timescale 1ns / 1ps
`include "macro.vh"

module cu(
    input   wire        rst,
    
    input   wire[5:0]   cu_opcode,
    input   wire[5:0]   cu_func,
    
    output  reg[1:0]    cu_branch,      //��ָ֧���ź�
    output  reg         cu_reg_dst,     //�Ĵ���д���ַ
    output  reg         cu_reg_write,   //�Ĵ���дʹ��
    output  reg         cu_alu_src,     //ALU��������Դ
    output  reg[3:0]    cu_alu_op,      //ALU������
    output  reg         cu_mem_write,   //���ݴ洢��дʹ��
    output  reg         cu_mem2reg,     //�Ĵ���д����Դ
    output  reg         cu_sign_ext     //������λ����չ
    );
endmodule
