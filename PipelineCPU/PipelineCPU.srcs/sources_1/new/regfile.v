`timescale 1ns / 1ps

module regfile(
    input   wire        clk,
    input   wire        rst,
    
    input   wire[4:0]   reg_ra1,    //����ַ
    input   wire[4:0]   reg_ra2,
    input   wire        reg_we,     //дʹ��
    input   wire[4:0]   reg_wa,     //д��ַ
    input   wire[31:0]  reg_wd,     //��д����
    input   wire        ex_wreg,    //����ִ�н׶ε�ָ���Ƿ�ҪдĿ�ļĴ���
    input   wire[4:0]   ex_wdst,    //����ִ�н׶ε�ָ��Ҫд��Ŀ�ļĴ�����ַ
    input   wire[31:0]  ex_wdata,   //����ִ�н׶ε�ָ��Ҫд��Ŀ�ļĴ���������
    input   wire        mem_wreg,   //���ڷô�׶ε�ָ���Ƿ�ҪдĿ�ļĴ���
    input   wire[4:0]   mem_wdst,   //���ڷô�׶ε�ָ��Ҫд��Ŀ�ļĴ�����ַ
    input   wire[31:0]  mem_wdata,  //���ڷô�׶ε�ָ��Ҫд��Ŀ�ļĴ���������
    
    output  wire[31:0]  reg_rd1,    //��������
    output  wire[31:0]  reg_rd2,
    
    input   wire        vga_en,     // �������ʹ���ź�
    input   wire[1:0]   vga_dir,    // �������
    output  wire[31:0]  vga_pos     // �ӼĴ���$1������λ����Ϣ
    );
    reg [31:0] regs[31:0];
    
    assign reg_rd1 = (ex_wreg && ex_wdst == reg_ra1) ? ex_wdata :
                     (mem_wreg && mem_wdst == reg_ra1) ? mem_wdata : regs[reg_ra1];
    assign reg_rd2 = (ex_wreg && ex_wdst == reg_ra2) ? ex_wdata :
                     (mem_wreg && mem_wdst == reg_ra2) ? mem_wdata : regs[reg_ra2];

    integer i;
    always @(negedge clk) begin
        if (rst) begin
            for (i = 0; i <= 31; i = i + 1) regs[i] <= 32'b0;
        end
        else if (reg_we) regs[reg_wa] <= reg_wd;
    end
    
    always @(posedge vga_en) regs[5'h6] <= {{14'b0},vga_dir} + 1'b1;   // �Ĵ���$6д�뷽������ź�
    assign  vga_pos = regs[5'h1];
endmodule
