module CPU(
    input clk_i,
    input rst_i
);

wire [31:0] pc_addr, instr;
wire [31:0] pc_next;   // 新增：下一個 PC
assign pc_next = pc_addr + 4;
wire [6:0]  opcode, funct7;
wire [2:0]  funct3;
wire [4:0]  rs1, rs2, rd;
wire [31:0] read_data1, read_data2;
wire [31:0] imm_extended;
wire [31:0] alu_input2;
wire [31:0] alu_result;
wire        zero;

wire        RegWrite, ALUSrc;
wire [1:0]  ALUOp;
wire [3:0]  ALUControl;

// PC 記憶體位置，每次 +4
PC PC(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .pc_i(pc_next),
    .pc_o(pc_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i(pc_addr),
    .instr_o(instr)
);


// 解碼指令欄位
assign opcode = instr[6:0];
assign rd     = instr[11:7];
assign funct3 = instr[14:12];
assign rs1    = instr[19:15];
assign rs2    = instr[24:20];
assign funct7 = instr[31:25];

// 控制單元
Control Control(
    .Op_i(opcode),
    .ALUSrc_o(ALUSrc),
    .ALUOp_o(ALUOp),
    .RegWrite_o(RegWrite)
);

// 註冊檔案
Registers Registers(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RS1addr_i(rs1),
    .RS2addr_i(rs2),
    .RDaddr_i(rd),
    .RDdata_i(alu_result),
    .RegWrite_i(RegWrite),
    .RS1data_o(read_data1),
    .RS2data_o(read_data2)
);


// 立即數擴展
Sign_Extend SE(
    .data_i(instr),
    .data_o(imm_extended)
);

// 決定 ALU 的第二個輸入：register 或 immediate
MUX32 MUX_ALUSrc(
    .data0_i(read_data2),
    .data1_i(imm_extended),
    .select_i(ALUSrc),
    .data_o(alu_input2)
);

// ALU 控制器（根據 funct3, funct7, ALUOp）
ALU_Control ALU_Control(
    .ALUOp_i(ALUOp),
    .Funct3_i(funct3),
    .Funct7_i(funct7),
    .ALUCtrl_o(ALUControl)
);

// ALU 運算單元
ALU ALU(
    .data1_i(read_data1),
    .data2_i(alu_input2),
    .ALUCtrl_i(ALUControl),
    .data_o(alu_result),
    .Zero_o(zero)
);

endmodule
