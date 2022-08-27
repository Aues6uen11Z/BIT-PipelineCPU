`timescale 1ns / 1ps

module branch(
    input   wire[31:0]  br_pc,
    input   wire[31:0]  br_imm,
    input   wire[1:0]   br_op,
    
    output  wire[31:0]  br_tgt
    );

// 不考虑br_tgt==00的不跳转情况，因为即使算了目标地址也不会被选中
assign br_tgt = (br_op==2'b11) ? {br_pc[31:28], br_imm[25:0], 2'b00} : (br_pc + (br_imm<<2));

endmodule
