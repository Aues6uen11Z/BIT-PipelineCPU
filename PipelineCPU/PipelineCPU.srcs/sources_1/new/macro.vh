//指令操作码字段
`define INSTR_FUNC  6'b000000
`define INSTR_ADDI  6'b001000
`define INSTR_ADDIU 6'b001001
`define INSTR_ANDI  6'b001100
`define INSTR_ORI   6'b001101
`define INSTR_XORI  6'b001110
`define INSTR_LUI   6'b001111
`define INSTR_LW    6'b100011
`define INSTR_SW    6'b101011
`define INSTR_BEQ   6'b000100
`define INSTR_BNE   6'b000101
`define INSTR_J     6'b000010

//指令功能码字段
`define FUNC_ADD    6'b100000
`define FUNC_ADDU   6'b100001
`define FUNC_SUB    6'b100010
`define FUNC_SUBU   6'b100011
`define FUNC_AND    6'b100100
`define FUNC_OR     6'b100101
`define FUNC_XOR    6'b100110
`define FUNC_NOR    6'b100111
`define FUNC_SLT    6'b101010
`define FUNC_SLTU   6'b101011

//指令ID
`define ID_NULL     0
`define ID_ADD      1
`define ID_ADDU     2
`define ID_SUB      3
`define ID_SUBU     4
`define ID_AND      5
`define ID_OR       6
`define ID_XOR      7
`define ID_NOR      8
`define ID_SLT      9
`define ID_SLTU     10
`define ID_ADDI     11
`define ID_ADDIU    12
`define ID_ANDI     13
`define ID_ORI      14
`define ID_XORI     15
`define ID_LUI      16
`define ID_LW       17
`define ID_SW       18
`define ID_BEQ      19
`define ID_BNE      20
`define ID_J        21

// ALU控制信号
`define ALU_NULL     4'b0000
`define ALU_ADD      4'b0001
`define ALU_SUB      4'b0010
`define ALU_AND      4'b0011
`define ALU_OR       4'b0100
`define ALU_XOR      4'b0101
`define ALU_NOR      4'b0110
`define ALU_SLT      4'b0111
`define ALU_SLTU     4'b1000
`define ALU_LUI      4'b1001
`define ALU_CMP      4'b1010

// VGA 640*480,60Hz时序参数
`define H_SCAN_TIME     10'd800
`define H_FRONT_PORCH   10'd16
`define H_ACTIVE_VIDEO  10'd640
`define H_BACK_PORCH    10'd48
`define H_SYNC_PULSE    10'd96
`define V_SCAN_TIME     10'd525
`define V_FRONT_PORCH   10'd10
`define V_ACTIVE_VIDEO  10'd480
`define V_BACK_PORCH    10'd33
`define V_SYNC_PULSE    10'd2
