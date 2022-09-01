`timescale 1ns / 1ps

module testbench();
    reg rstn, clk, btn_left, btn_right, btn_up, btn_down;
    initial begin
        rstn = 1'b0;
        clk = 1'b1;
        btn_left = 1'b0;
        btn_right = 1'b0;
        btn_up = 1'b0;
        btn_down = 1'b0;
        #20 rstn = 1'b1;
    end

    always #5 clk = ~clk;
    
    always begin
        #200
        btn_left = 1'b1;
        #1000
        btn_left = 1'b0;
        
        #200
        btn_right = 1'b1;
        #30
        btn_right = 1'b0;
        
        #200
        btn_up = 1'b1;
        #30
        btn_up = 1'b0;
        
        #200
        btn_down = 1'b1;
        #30
        btn_down = 1'b0;
        
    end
    
    sys_top _sys_top(
        .clk(clk),
        .rstn(rstn),
        .btn_left(btn_left), 
        .btn_right(btn_right), 
        .btn_up(btn_up),
        .btn_down(btn_down),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );
endmodule
