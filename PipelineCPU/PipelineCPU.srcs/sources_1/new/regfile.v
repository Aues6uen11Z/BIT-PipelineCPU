`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[4:0]   reg_ra1,    //读地址
    input   wire[4:0]   reg_ra2,
    input   wire        reg_we,     //写使能
    input   wire[4:0]   reg_wa,     //写地址
    input   wire[31:0]  reg_wd,     //待写数据
    input   wire        ex_wreg,    //处于执行阶段的指令是否要写目的寄存器
    input   wire[4:0]   ex_wdst,    //处于执行阶段的指令要写的目的寄存器地址
    input   wire[31:0]  ex_wdata,   //处于执行阶段的指令要写入目的寄存器的数据
    input   wire        mem_wreg,   //处于访存阶段的指令是否要写目的寄存器
    input   wire[4:0]   mem_wdst,   //处于访存阶段的指令要写的目的寄存器地址
    input   wire[31:0]  mem_wdata,  //处于访存阶段的指令要写入目的寄存器的数据
    
    output  wire[31:0]  reg_rd1,    //读出数据
    output  wire[31:0]  reg_rd2,
    
    input   wire        vga_en,     // 方向控制使能信号
    input   wire[1:0]   vga_dir,    // 方向控制
    output  wire[31:0]  vga_pos     // 从寄存器$1读出的位置信息
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
        else if (reg_we) regs[reg_wa] <= reg_wd;
    end
    
    always @(posedge vga_en) regs[5'h6] <= {{14'b0},vga_dir} + 1'b1;   // 寄存器$6写入方向控制信号
    assign  vga_pos = regs[5'h1];
endmodule
