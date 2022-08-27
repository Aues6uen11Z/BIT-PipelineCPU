`timescale 1ns / 1ps

module extension(
    input   wire[15:0]  ext_imm16,
    input   wire        ext_sign,
    
    output  wire[31:0]  ext_imm32
    );
    
assign ext_imm32 = (ext_sign==1) ? {{16{ext_imm16[15]}}, ext_imm16[15:0]} : {16'b0, ext_imm16[15:0]};

endmodule
