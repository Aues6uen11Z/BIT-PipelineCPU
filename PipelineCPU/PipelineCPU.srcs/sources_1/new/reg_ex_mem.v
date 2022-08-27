`timescale 1ns / 1ps

module reg_ex_mem(
    input   wire        clk,
    input   wire        rst,
    
    input   wire        ex_reg_write,
    input   wire        ex_mem_write,
    input   wire        ex_mem2reg,
    input   wire[31:0]  ex_alu_out,
    input   wire[31:0]  ex_mem_wd,
    input   wire[31:0]  ex_reg_wa,
    
    output  reg         mem_reg_write,
    output  reg         mem_mem_write,
    output  reg         mem_mem2reg,
    output  reg[31:0]   mem_alu_out,
    output  reg[31:0]   mem_mem_wd,
    output  reg[31:0]   mem_reg_wa
    );
    
    always@ (posedge clk) begin
        if(rst == 0) begin
            mem_reg_wa <= 32'b0;
            mem_reg_write <= 1'b0;
            mem_mem_write <= 1'b0;
            mem_mem_wd <= 32'b0;
            mem_alu_out <= 32'b0;
            mem_mem2reg <= 1'b0;
        end else begin
            mem_reg_wa <= ex_reg_wa;
            mem_mem_wd <= ex_mem_wd;
            mem_reg_write <= ex_reg_write;
            mem_mem_write <= ex_mem_write;
            mem_alu_out <= ex_alu_out;
            mem_mem2reg <= ex_mem2reg;
        end
    end
            
endmodule