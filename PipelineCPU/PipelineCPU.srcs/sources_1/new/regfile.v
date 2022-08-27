`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  reg_ra1,    //读地址
    input   wire[31:0]  reg_ra2,
    input   wire        reg_we,     //写使能
    input   wire[31:0]  reg_wa,     //写地址
    input   wire[31:0]  reg_wd,     //待写数据
    
    output  wire[31:0]  reg_rd1,    //读出数据
    output  wire[31:0]  reg_rd2
    );
    
    reg [31:0] regs[31:0];
    
    assign reg_rd1 = regs[reg_ra1];
    assign reg_rd2 = regs[reg_ra2];
    
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i <= 31; i = i + 1) regs[i] <= 32'b0;
        end
        else if (reg_we == 1'b1) regs[reg_wa] <= reg_wd;
    end
endmodule
