`timescale 1ns/1ps

`define R_TYPE     7'b0110011
`define I_TYPE_ALU 7'b0010011
`define I_TYPE_LW  7'b0000011
`define S_TYPE     7'b0100011
`define SB_TYPE    7'b1100011

module Control (
    input  wire [6:0] Op_i,
    input  wire       NoOp_i,
    output reg  [1:0] ALUOp_o,
    output reg        ALUSrc_o,
    output reg        RegWrite_o,
    output reg        MemtoReg_o,
    output reg        MemRead_o,
    output reg        MemWrite_o,
    output reg        Branch_o
);

    // 初始化所有控制信號為 0
    task init_signals;
        begin
            ALUOp_o      = 2'b00;
            ALUSrc_o     = 1'b0;
            RegWrite_o   = 1'b0;
            MemtoReg_o   = 1'b0;
            MemRead_o    = 1'b0;
            MemWrite_o   = 1'b0;
            Branch_o     = 1'b0;
        end
    endtask

    always @(*) begin
        // 先全清
        init_signals();

        if (NoOp_i) begin
            // 當插入 bubble 時，什麼也不做（保持清零）
        end
        else begin
            case (Op_i)
                `R_TYPE: begin
                    // R-type: ALU 演算，寫回 register
                    ALUOp_o    = 2'b10;
                    RegWrite_o = 1'b1;
                end
                `I_TYPE_ALU: begin
                    // I-type ALU（如 addi, srai）
                    ALUOp_o    = 2'b11;
                    ALUSrc_o   = 1'b1;
                    RegWrite_o = 1'b1;
                end
                `I_TYPE_LW: begin
                    // Load word
                    ALUOp_o     = 2'b01;  // 用 ADD 計算位址
                    ALUSrc_o    = 1'b1;
                    RegWrite_o  = 1'b1;
                    MemtoReg_o  = 1'b1;
                    MemRead_o   = 1'b1;
                end
                `S_TYPE: begin
                    // Store word
                    ALUOp_o    = 2'b01;  // 用 ADD 計算位址
                    ALUSrc_o   = 1'b1;
                    MemWrite_o = 1'b1;
                end
                `SB_TYPE: begin
                    // Branch equal
                    ALUOp_o    = 2'b00;  // 用 SUB 比較
                    Branch_o   = 1'b1;
                end
                default: begin
                    // 未知 opcode，保持所有信號為 0
                end
            endcase
        end
    end

endmodule
