`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  reg_ra1,    //读地址
    input   wire[31:0]  reg_ra2,
    input   wire        reg_we,     //写使能
    input   wire[31:0]  reg_wa,     //写地址
    input   wire[31:0]  reg_wd,     //待写数据
    input   wire        ex_wreg,    //处于执行阶段的指令是否要写目的寄存器
    input   wire[31:0]  ex_wdst,    //处于执行阶段的指令要写的目的寄存器地址
    input   wire[31:0]  ex_wdata,   //处于执行阶段的指令要写入目的寄存器的数据
    input   wire        mem_wreg,   //处于访存阶段的指令是否要写目的寄存器
    input   wire[31:0]  mem_wdst,   //处于访存阶段的指令要写的目的寄存器地址
    input   wire[31:0]  mem_wdata,  //处于访存阶段的指令要写入目的寄存器的数据
    
    output  wire[31:0]  reg_rd1,    //读出数据
    output  wire[31:0]  reg_rd2
    );
    reg [31:0] regs[31:0];
    
    assign reg_rd1 = (ex_wreg && ex_wdst == reg_ra1) ? ex_wdata :
                     (mem_wreg && mem_wdst == reg_ra1) ? mem_wdata : regs[reg_ra1];
    assign reg_rd2 = (ex_wreg && ex_wdst == reg_ra2) ? ex_wdata :
                     (mem_wreg && mem_wdst == reg_ra2) ? mem_wdata : regs[reg_ra2];

    integer i;
    always @(negedge clk) begin
        if (rst) begin
            for (i = 0; i <= 31; i = i + 1) regs[i] <= 32'b0;
        end
        else if (reg_we == 1'b1) regs[reg_wa] <= reg_wd;
    end
endmodule
