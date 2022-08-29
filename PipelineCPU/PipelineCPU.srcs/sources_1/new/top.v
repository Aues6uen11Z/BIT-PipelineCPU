`timescale 1ns / 1ps

module top(
    input   wire    clk,
    input   wire    rstn
    );
wire rst = !rstn;

/* ----------------取指阶段---------------- */
// 指令计数器
wire[31:0]  pc_i;
wire[31:0]  pc_o;
pc _pc(
    .clk(clk),
    .rst(rst),
    .pc_i(pc_i),
    .pc_o(pc_o)
);

// 指令存储器
wire[31:0]  if_instr;
instr_mem _instr_mem(
    .a(pc_o[11:2]),
    .spo(if_instr)
);

// IF/ID流水寄存器
wire[31:0]  if_pc;
wire[31:0]  id_pc;
wire[31:0]  id_instr;
assign  if_pc = pc_o + 32'h4;
reg_if_id _reg_if_id(
    .clk(clk),
    .rst(rst),
    .if_pc(if_pc),
    .if_instr(if_instr),
    .id_pc(id_pc),
    .id_instr(id_instr)
);


/* ----------------译码阶段---------------- */
// 控制单元
wire[5:0]   opcode;     //不传到下一级不写前缀，下同
wire[5:0]   func;
wire[1:0]   branch;
wire        reg_dst;
wire        id_reg_write;
wire        id_alu_src;
wire[3:0]   id_alu_op;
wire        id_mem_write;
wire        id_mem2reg;
wire        sign_ext;

assign opcode = id_instr[31:26];
assign func = id_instr[5:0];

cu _cu(
    .cu_opcode(opcode),
    .cu_func(func),
    .cu_branch(branch),
    .cu_reg_dst(reg_dst),
    .cu_reg_write(id_reg_write),
    .cu_alu_src(id_alu_src),
    .cu_alu_op(id_alu_op),
    .cu_mem_write(id_mem_write),
    .cu_mem2reg(id_mem2reg),
    .cu_sign_ext(sign_ext)
);

// 寄存器堆
wire[31:0]  ra1;
wire[31:0]  ra2;
wire[31:0]  id_reg_wa;
wire[31:0]  id_reg_rd1;
wire[31:0]  id_reg_rd2;
// 执行阶段数据前推
wire        ex_reg_write;
wire[31:0]  ex_reg_wa;
wire[31:0]  ex_reg_wd;
// 访存阶段数据前推
wire        mem_reg_write;
wire[31:0]  mem_reg_wa;
wire[31:0]  mem_reg_wd;
// 写回阶段赋值
wire        wb_reg_write;
wire[31:0]  wb_reg_wa;
wire[31:0]  wb_reg_wd;

assign ra1 = id_instr[25:21];
assign ra2 = id_instr[20:16];
assign id_reg_wa = (reg_dst==1) ? id_instr[15:11] : id_instr[20:16];

regfile _regfile(
    .clk(clk),
    .rst(rst),
    .reg_ra1(ra1),
    .reg_ra2(ra2),
    .reg_we(wb_reg_write),
    .reg_wa(wb_reg_wa),
    .reg_wd(wb_reg_wd),
    .ex_wreg(ex_reg_write),
    .ex_wdst(ex_reg_wa),
    .ex_wdata(ex_reg_wd),
    .mem_wreg(mem_reg_write),
    .mem_wdst(mem_reg_wa),
    .mem_wdata(mem_reg_wd),
    .reg_rd1(id_reg_rd1),
    .reg_rd2(id_reg_rd2)
);

// 符号扩展单元
wire[15:0]  imm16;
wire[31:0]  id_imm;
assign imm16 = id_instr[15:0];
extension _extension(
    .ext_imm16(imm16),
    .ext_sign(sign_ext),
    .ext_imm32(id_imm)
);

// 分支跳转单元
wire branch_taken;
wire equal;
wire[31:0]  br_tgt;
assign branch_taken = (branch==2'b11) ? 1'b1 :
                    (branch==2'b01 && equal==1'b1) ? 1'b1 :
                    (branch==2'b10 && equal==1'b0) ? 1'b1 :
                    1'b0;
branch _branch(
    .br_pc(id_pc),
    .br_imm(id_imm),
    .br_op(branch),
    .br_rd1(id_reg_rd1),
    .br_rd2(id_reg_rd2),
    .br_equal(equal),
    .br_tgt(br_tgt)
);

assign pc_i = (branch_taken==1) ? br_tgt : if_pc;

// ID/EX流水寄存器
wire        ex_alu_src;
wire[3:0]   ex_alu_op;
wire        ex_mem_write;
wire        ex_mem2reg;
wire[31:0]  ex_reg_rd1;
wire[31:0]  ex_reg_rd2;
wire[31:0]  ex_imm;
reg_id_ex _reg_id_ex(
    .clk(clk),
    .rst(rst),
    .id_reg_write(id_reg_write),
    .id_alu_src(id_alu_src),
    .id_alu_op(id_alu_op),
    .id_mem_write(id_mem_write),
    .id_mem2reg(id_mem2reg),
    .id_reg_rd1(id_reg_rd1),
    .id_reg_rd2(id_reg_rd2),
    .id_reg_wa(id_reg_wa),
    .id_imm(id_imm),
    .ex_reg_write(ex_reg_write),
    .ex_alu_src(ex_alu_src),
    .ex_alu_op(ex_alu_op),
    .ex_mem_write(ex_mem_write),
    .ex_mem2reg(ex_mem2reg),
    .ex_reg_rd1(ex_reg_rd1),
    .ex_reg_rd2(ex_reg_rd2),
    .ex_reg_wa(ex_reg_wa),
    .ex_imm(ex_imm)
);


/* ----------------执行阶段---------------- */
// 算数逻辑单元
wire[31:0]  alu_in2;
wire[31:0]  ex_alu_out;
assign alu_in2 = (ex_alu_src==1) ? ex_imm : ex_reg_rd2;
assign ex_reg_wd = ex_alu_out;
alu _alu(
    .alu_op(ex_alu_op),
    .alu_in1(ex_reg_rd1),
    .alu_in2(alu_in2),
    .alu_out(ex_alu_out)
);

// EX/MEM流水寄存器
wire        mem_mem_write;
wire        mem_mem2reg;
wire[31:0]  mem_mem_wd;
wire[31:0]  mem_alu_out;
reg_ex_mem _reg_ex_mem(
    .clk(clk),
    .rst(rst),
    .ex_reg_write(ex_reg_write),
    .ex_mem_write(ex_mem_write),
    .ex_mem2reg(ex_mem2reg),
    .ex_alu_out(ex_alu_out),
    .ex_mem_wd(ex_reg_rd2),
    .ex_reg_wa(ex_reg_wa),
    .mem_reg_write(mem_reg_write),
    .mem_mem_write(mem_mem_write),
    .mem_mem2reg(mem_mem2reg),
    .mem_alu_out(mem_alu_out),
    .mem_mem_wd(mem_mem_wd),
    .mem_reg_wa(mem_reg_wa)
);


/* ----------------访存阶段---------------- */
// 数据存储器
wire[31:0]  mem_mem_rd;
data_mem _data_mem(
    .a(mem_alu_out[11:2]),
    .d(mem_mem_wd),
    .clk(clk),
    .we(mem_mem_write),
    .spo(mem_mem_rd)
);
assign mem_reg_wd = (mem_mem2reg==1) ? mem_mem_rd : mem_alu_out;

// MEM/WB流水寄存器
wire        wb_mem2reg;
wire[31:0]  wb_alu_out;
wire[31:0]  wb_mem_rd;
reg_mem_wb _reg_mem_wb(
    .clk(clk),
    .rst(rst),
    .mem_reg_write(mem_reg_write),
    .mem_mem2reg(mem_mem2reg),
    .mem_alu_out(mem_alu_out),
    .mem_mem_rd(mem_mem_rd),
    .mem_reg_wa(mem_reg_wa),
    .wb_reg_write(wb_reg_write),
    .wb_mem2reg(wb_mem2reg),
    .wb_alu_out(wb_alu_out),
    .wb_mem_rd(wb_mem_rd),
    .wb_reg_wa(wb_reg_wa)
);


/* ----------------写回阶段---------------- */
assign wb_reg_wd = (wb_mem2reg==1) ? wb_mem_rd : wb_alu_out;


endmodule
