`timescale 1ns / 1ps
`include "macro.vh"

module display(
    input   wire        clk,        // 25.175MHz
    input   wire        rstn,       // ��λ�ź�
    input   wire[31:0]  vga_pos,    // λ��
    
    output   wire       hsync,      // ��ͬ���ź�
    output   wire       vsync,      // ��ͬ���ź�
    output   wire[3:0]  red,        // ��ɫ����ź�
    output   wire[3:0]  green,      // ��ɫ����ź�
    output   wire[3:0]  blue        // ��ɫ����ź�
    );

    reg reg_h;
    reg reg_v;
    reg[3:0] reg_red;
    reg[3:0] reg_green;
    reg[3:0] reg_blue;

    assign hsync = reg_h;
    assign vsync = reg_v;
    assign red = reg_red;
    assign green = reg_green;
    assign blue = reg_blue;
    
    // ������ˢ�ºͳ�ˢ��
    reg[9:0] h_count;
    reg[9:0] v_count;
    always @(posedge clk) begin
        if (!rstn) begin
            h_count <= 10'b0;
            v_count <= 10'b0;
        end
        else begin
            if (h_count == `H_SCAN_TIME - 1) begin
                h_count <= 10'b0;
                if (v_count == `V_SCAN_TIME - 1) begin
                    v_count <= 10'b0;
                end
                else begin
                    v_count <= v_count + 1'b1;
                end
            end
            else begin
                h_count <= h_count + 1'b1;
            end
        end
    end

    // ��ͬ���źŸ�ֵ
    always @(posedge clk) begin
        if (h_count < `H_SYNC_PULSE) begin
            reg_h <= 1'b0;
        end
        else begin
            reg_h <= 1'b1;
        end
    end
    // ��ͬ���źŸ�ֵ
    always @(posedge clk) begin
        if (v_count < `V_SYNC_PULSE) begin
            reg_v <= 1'b0;
        end
        else begin
            reg_v <= 1'b1;
        end
    end
    
    // ����Ŀ��
    wire[9:0] x, y;
    assign x = vga_pos % 10'd800;
    assign y = vga_pos / 10'd800;
    wire[9:0] top = y - 10'd15;
    wire[9:0] bottom = y + 10'd15;
    wire[9:0] left = x - 10'd15;
    wire[9:0] right = x + 10'd15;
    always @(posedge clk) begin
        if (h_count>left && h_count<right && v_count>top && v_count<bottom) begin
            if(v_count>top+10'd6 && v_count<top+10'd12) begin
                if((h_count>left+10'd3 && h_count<left+10'd12) || (h_count>right-10'd12 && h_count<right-10'd3)) begin  // �۾�
                    reg_red   <= 4'b0;
                    reg_green <= 4'b0;
                    reg_blue  <= 4'b0;
                end
                else begin   // ��
                    reg_red   <= 4'b0100;
                    reg_green <= 4'b0010;
                    reg_blue  <= 4'b0001;
                end
            end
            else if(h_count>left+10'd10 && h_count<right-10'd10 && v_count>bottom-10'd10 && v_count<bottom-10'd4) begin // ��
                reg_red     <= 4'b1000;
                reg_green   <= 4'b0001;
                reg_blue    <= 4'b0001;
            end
            else begin  // ��
                reg_red   <= 4'b0100;
                reg_green <= 4'b0010;
                reg_blue  <= 4'b0001;
            end
        end
        else begin  // ����
                reg_red   <= 4'b0;
                reg_green <= 4'b0;
                reg_blue  <= 4'b0;
        end
    end


endmodule
