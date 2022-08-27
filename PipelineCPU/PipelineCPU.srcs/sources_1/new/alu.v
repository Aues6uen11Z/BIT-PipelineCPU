`timescale 1ns / 1ps
`include "macro.vh"

module alu(
    input   wire[3:0]   alu_op,
    input   wire[31:0]  alu_in1,
    input   wire[31:0]  alu_in2,
    
    output  wire[31:0]   alu_out,
    output  wire        alu_equal
    );
    
    wire [31:0] in1   = alu_in1;
    wire [31:0] in2   = alu_in2;
    wire [31:0] in2_bu = (~alu_in2)+1;
    wire [31:0] result_sub = in1 + in2_bu;
    
    wire [31:0] o_add = in1+in2;
    wire [31:0] o_sub = result_sub;
    wire [31:0] o_and = in1&in2;
    wire [31:0] o_or = in1|in2;
    wire [31:0] o_xor = in1^in2;
    wire [31:0] o_nor = ~o_or;
    wire [31:0] o_slt = ((in1[31]&&!in2[31])||(!in1[31]&&!in2[31]&&result_sub[31])||(in1[31]&&in2[31]&&result_sub[31]));
    wire [31:0] o_sltu = (in1<in2) ;    
    wire [31:0] o_lui = {alu_in2[15:0], 16'b0};
    
    assign alu_out = (alu_op == `ALU_ADD) ? o_add[31:0] :
                     (alu_op == `ALU_SUB) ? o_sub[31:0] :
                     (alu_op == `ALU_AND) ? o_and[31:0] :
                     (alu_op == `ALU_OR) ? o_or[31:0] :
                     (alu_op == `ALU_XOR) ? o_xor[31:0] :
                     (alu_op == `ALU_NOR) ? o_nor[31:0] :
                     (alu_op == `ALU_SLT) ? o_slt[31:0] :
                     (alu_op == `ALU_SLTU) ? o_sltu[31:0] :
                     (alu_op == `ALU_LUI) ? o_lui[31:0] :
                     32'b0;
    assign alu_equal = (in1 == in2) ? 1 : 0;
                     
endmodule
