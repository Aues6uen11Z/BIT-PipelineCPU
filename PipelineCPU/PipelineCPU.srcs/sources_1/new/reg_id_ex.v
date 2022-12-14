`timescale 1ns / 1ps

module reg_id_ex(
    input   wire        clk,
    input   wire        rst,
    
    input   wire        id_reg_write,
    input   wire        id_alu_src,
    input   wire[3:0]   id_alu_op,
    input   wire        id_mem_write,
    input   wire        id_mem2reg,
    input   wire[31:0]  id_reg_rd1,
    input   wire[31:0]  id_reg_rd2,
    input   wire[4:0]   id_reg_wa,
    input   wire[31:0]  id_imm,
    
    output  reg         ex_reg_write,
    output  reg         ex_alu_src,
    output  reg[3:0]    ex_alu_op,
    output  reg         ex_mem_write,
    output  reg         ex_mem2reg,
    output  reg[31:0]   ex_reg_rd1,
    output  reg[31:0]   ex_reg_rd2,
    output  reg[4:0]    ex_reg_wa,
    output  reg[31:0]   ex_imm
    );
    
    always @ (posedge clk) begin
        if (rst) begin
            ex_reg_write <= 1'b0;
            ex_alu_src <= 1'b0;
            ex_alu_op <= 4'b0;
            ex_mem_write <= 1'b0;
            ex_mem2reg <= 1'b0;
            ex_reg_rd1 <= 32'b0;
            ex_reg_rd2 <= 32'b0;
            ex_reg_wa <= 5'b0;
            ex_imm <= 32'b0;
        end else begin
            ex_reg_write <= id_reg_write;
            ex_alu_src <= id_alu_src;
            ex_alu_op <= id_alu_op;
            ex_mem_write <= id_mem_write;
            ex_mem2reg <= id_mem2reg;
            ex_reg_rd1 <= id_reg_rd1;
            ex_reg_rd2 <= id_reg_rd2;
            ex_reg_wa <= id_reg_wa;
            ex_imm <= id_imm;
        end
    end    
    
endmodule
