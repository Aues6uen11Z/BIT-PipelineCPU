`timescale 1ns / 1ps
`include "macro.vh"

module alu(
    input   wire[3:0]   alu_op,
    input   wire[31:0]  alu_in1,
    input   wire[31:0]  alu_in2,
    
    output  reg[31:0]   alu_out,
    output  wire        alu_equal
    );
endmodule