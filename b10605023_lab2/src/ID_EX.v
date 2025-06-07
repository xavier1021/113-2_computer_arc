`timescale 1ns/1ps

module ID_EX (
    input  wire        clk_i,
    input  wire        rst_i,
    // signal input
    input  wire [31:0] RS1data_i,
    input  wire [31:0] RS2data_i,
    input  wire [31:0] immed_i,
    input  wire [31:0] pc_i,
    input  wire [31:0] instr_i,
    input  wire [4:0]  RS1addr_i,
    input  wire [4:0]  RS2addr_i,
    input  wire [4:0]  Rd_i,
    input  wire        RegWrite_i,
    input  wire        MemtoReg_i,
    input  wire        MemRead_i,
    input  wire        MemWrite_i,
    input  wire        ALUSrc_i,
    input  wire [1:0]  ALUOp_i,

    // 對應输出
    output reg  [31:0] RS1data_o,
    output reg  [31:0] RS2data_o,
    output reg  [31:0] immed_o,
    output reg  [31:0] pc_o,
    output reg  [31:0] instr_o,
    output reg  [4:0]  RS1addr_o,
    output reg  [4:0]  RS2addr_o,
    output reg  [4:0]  Rd_o,
    output reg         RegWrite_o,
    output reg         MemtoReg_o,
    output reg         MemRead_o,
    output reg         MemWrite_o,
    output reg         ALUSrc_o,
    output reg  [1:0]  ALUOp_o
);

    // 將所有輸入信號打包
    reg [204:0] pipeline_reg;

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            // 一起清零
            {RS1data_o, RS2data_o, immed_o, pc_o, instr_o,
             RS1addr_o, RS2addr_o, Rd_o,
             RegWrite_o, MemtoReg_o, MemRead_o, MemWrite_o, ALUSrc_o, ALUOp_o}
             <= {32+32+32+32+32{1'b0}};
        end
        else begin
            // 逐一更新
            RS1data_o   <= RS1data_i;
            RS2data_o   <= RS2data_i;
            immed_o     <= immed_i;
            pc_o        <= pc_i;
            instr_o     <= instr_i;
            RS1addr_o   <= RS1addr_i;
            RS2addr_o   <= RS2addr_i;
            Rd_o        <= Rd_i;
            RegWrite_o  <= RegWrite_i;
            MemtoReg_o  <= MemtoReg_i;
            MemRead_o   <= MemRead_i;
            MemWrite_o  <= MemWrite_i;
            ALUSrc_o    <= ALUSrc_i;
            ALUOp_o     <= ALUOp_i;
        end
    end

endmodule
