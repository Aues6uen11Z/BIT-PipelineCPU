`timescale 1ns / 1ps
`include "macro.vh"

module cu(
    input   wire[5:0]   cu_opcode,
    input   wire[5:0]   cu_func,
    
    output  wire[1:0]   cu_branch,      //分支指令信号
    output  wire        cu_reg_dst,     //寄存器写入地址
    output  wire        cu_reg_write,   //寄存器写使能
    output  wire        cu_alu_src,     //ALU操作数来源
    output  wire[3:0]   cu_alu_op,      //ALU操作码
    output  wire        cu_mem_write,   //数据存储器写使能
    output  wire        cu_mem2reg,     //寄存器写回来源
    output  wire        cu_sign_ext     //立即数位数扩展
    );
    
    wire[4:0] instr_id = get_instr_id(cu_opcode, cu_func);
    function [4:0] get_instr_id(input[5:0] opcode, input[5:0] func);
    begin
        case(opcode)
            `INSTR_ADDI : get_instr_id = `ID_ADDI;
            `INSTR_ADDIU: get_instr_id = `ID_ADDIU;
            `INSTR_ANDI : get_instr_id = `ID_ANDI;
            `INSTR_ORI  : get_instr_id = `ID_ORI;
            `INSTR_XORI : get_instr_id = `ID_XORI;
            `INSTR_LUI  : get_instr_id = `ID_LUI;
            `INSTR_LW   : get_instr_id = `ID_LW;
            `INSTR_SW   : get_instr_id = `ID_SW;
            `INSTR_BEQ  : get_instr_id = `ID_BEQ;
            `INSTR_BNE  : get_instr_id = `ID_BNE;
            `INSTR_J    : get_instr_id = `ID_J;
            `INSTR_FUNC : begin
                case(func)
                    `FUNC_ADD   : get_instr_id = `ID_ADD;
                    `FUNC_ADDU  : get_instr_id = `ID_ADDU;
                    `FUNC_SUB   : get_instr_id = `ID_SUB;
                    `FUNC_SUBU  : get_instr_id = `ID_SUBU;
                    `FUNC_AND   : get_instr_id = `ID_AND;
                    `FUNC_OR    : get_instr_id = `ID_OR;
                    `FUNC_XOR   : get_instr_id = `ID_XOR;
                    `FUNC_NOR   : get_instr_id = `ID_NOR;
                    `FUNC_SLT   : get_instr_id = `ID_SLT;
                    `FUNC_SLTU  : get_instr_id = `ID_SLTU;
                    default     : get_instr_id = `ID_NULL;
                endcase
            end
            default     : get_instr_id = `ID_NULL;
        endcase
    end
    endfunction
    
    // 根据指令给各操作信号赋值
    assign cu_branch = (instr_id==`ID_BEQ) ? 2'b01 :
                        (instr_id==`ID_BNE) ? 2'b10 :
                        (instr_id==`ID_J) ? 2'b11 :
                        2'b00;
    assign cu_mem_write = (instr_id==`ID_SW) ? 1 : 0;
    assign cu_mem2reg = (instr_id==`ID_LW) ? 1 : 0;
    reg[20:0] mask_reg_dst = 21'b111111111100000000000;
    assign cu_reg_dst = mask_reg_dst[instr_id];
    reg[20:0] mask_reg_write = 21'b111111111111111110000;
    assign cu_reg_write = mask_reg_write[instr_id];
    reg[20:0] mask_alu_src = 21'b000000000011111111000;
    assign cu_alu_src = mask_alu_src[instr_id];
    reg[20:0] mask_sign_ext = 21'b000000000010000011110;
    assign cu_sign_ext = mask_sign_ext[instr_id];
    
    assign cu_alu_op = get_alu_op(instr_id);
    function [3:0] get_alu_op(input [3:0] instr_id);
    begin
        case(instr_id)
            `ID_ADD,`ID_ADDU,
            `ID_ADDI,`ID_ADDIU,
            `ID_LW,`ID_SW       : get_alu_op = `ALU_ADD;
            `ID_SUB,`ID_SUBU    : get_alu_op = `ALU_SUB;
            `ID_AND,`ID_ANDI    : get_alu_op = `ALU_AND;
            `ID_OR,`ID_ORI      : get_alu_op = `ALU_OR;
            `ID_XOR,`ID_XORI    : get_alu_op = `ALU_XOR;
            `ID_NOR             : get_alu_op = `ALU_NOR;
            `ID_SLT             : get_alu_op = `ALU_SLT;
            `ID_SLTU            : get_alu_op = `ALU_SLTU;
            `ID_LUI             : get_alu_op = `ALU_LUI;
            `ID_BEQ,`ID_BNE     : get_alu_op = `ALU_CMP;
            `ID_J               : get_alu_op = `ALU_NULL;
            default             : get_alu_op = `ALU_NULL;
        endcase
    end
    endfunction

endmodule
