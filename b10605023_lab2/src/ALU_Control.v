`timescale 1ns/1ps

`define AND   3'b000
`define XOR   3'b001
`define SLL   3'b010
`define ADD   3'b011
`define SUB   3'b100
`define MUL   3'b101
`define ADDI  3'b110
`define SRAI  3'b111

module ALU_Control (
    input  wire [1:0] ALUOp_i,
    input  wire [6:0] funct7_i,
    input  wire [2:0] funct3_i,
    output reg  [2:0] ALUCtr_o
);

    // Combine funct7 和 funct3，方便一次 compare
    wire [9:0] F7_F3 = {funct7_i, funct3_i};

    always @(*) begin
        // 預設為非法碼
        ALUCtr_o = 3'bxxx;

        // 根據 ALUOp_i 選路
        if      (ALUOp_i == 2'b00) begin
            // 分支用 sub
            ALUCtr_o = `SUB;
        end
        else if (ALUOp_i == 2'b01) begin
            // load/store 用 add
            ALUCtr_o = `ADD;
        end
        else if (ALUOp_i == 2'b10) begin
            // R-type: 依 funct7|funct3 決定
            case (F7_F3)
                10'b0000000_111: ALUCtr_o = `AND;  // AND
                10'b0000000_100: ALUCtr_o = `XOR;  // XOR
                10'b0000000_001: ALUCtr_o = `SLL;  // SLL
                10'b0000000_000: ALUCtr_o = `ADD;  // ADD
                10'b0100000_000: ALUCtr_o = `SUB;  // SUB
                10'b0000001_000: ALUCtr_o = `MUL;  // MUL
                default:         ALUCtr_o = 3'bxxx; // 其他不合法
            endcase
        end
        else if (ALUOp_i == 2'b11) begin
            // I-type: immediate
            if (funct3_i == 3'b000) begin
                ALUCtr_o = `ADDI;  // ADDI
            end
            else if (funct3_i == 3'b101) begin
                ALUCtr_o = `SRAI;  // SRAI
            end
            else begin
                ALUCtr_o = 3'bxxx;
            end
        end
        else begin
            // 不支援的 ALUOp，保留預設 xxx
            ALUCtr_o = 3'bxxx;
        end
    end

endmodule
