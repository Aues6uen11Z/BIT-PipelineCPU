`timescale 1ns / 1ps

module pc(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[31:0]  pc_i,
    
    output  reg[31:0]   pc_o
    );
    
    always @ (posedge clk) begin
        if(rst) begin
            pc_o <= 32'b0;
        end else begin
            pc_o <= pc_i;
        end
    end

endmodule
