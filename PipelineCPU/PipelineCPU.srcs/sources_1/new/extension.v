`timescale 1ns / 1ps

module extension(
    input   wire[15:0]  ext_imm16,
    input   wire        ext_sign,
    
    output  reg[31:0]   ext_imm32
    );
endmodule
