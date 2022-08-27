`timescale 1ns / 1ps

module branch(
    input   wire[31:0]  br_pc,
    input   wire[31:0]  br_imm,
    input   wire[1:0]   br_op,
    
    output  wire[31:0]  br_tgt
    );
endmodule
