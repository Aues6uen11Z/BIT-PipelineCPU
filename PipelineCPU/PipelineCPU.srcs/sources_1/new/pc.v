`timescale 1ns / 1ps

module pc(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  pc_i,
    
    output  reg[31:0]   pc_o
    );
endmodule
