`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  reg_ra1,    //����ַ
    input   wire[31:0]  reg_ra2,
    input   wire        reg_we,     //дʹ��
    input   wire[31:0]  reg_wa,     //д��ַ
    input   wire[31:0]  reg_wd,     //��д����
    
    output  reg[31:0]   reg_rd1,    //��������
    output  reg[31:0]   reg_rd2
    );
endmodule
