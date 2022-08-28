`timescale 1ns / 1ps

module testbench();
    reg rstn, clk;
    initial begin
        rstn = 1'b0;
        clk = 1'b1;
        #20 rstn = 1'b1;
    end

    always #5 clk = ~clk;
    
    top _top(
        .rstn(rstn),
        .clk(clk)
    );
endmodule
