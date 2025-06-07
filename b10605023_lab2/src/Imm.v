`timescale 1ns/1ps

`define OPC_I_ALU 7'b0010011
`define OPC_I_LW  7'b0000011
`define OPC_S     7'b0100011
`define OPC_SB    7'b1100011

module Imm (
    input  wire [31:0] instr_i,
    output reg  [11:0] immed_o
);

    // 指令的imm拆分
    wire [11:0] imm_i   = instr_i[31:20];                  // I-type
    wire [11:0] imm_s   = {instr_i[31:25], instr_i[11:7]};  // S-type
    wire [11:0] imm_sb  = {
        instr_i[31],           // sign
        instr_i[7],            // bit 11
        instr_i[30:25],        // bits 10:5
        instr_i[11:8]          // bits 4:1
    };

    always @(*) begin
        // 取 I-type 的低 12 位
        immed_o = imm_i;

        case (instr_i[6:0])
            `OPC_I_ALU,
            `OPC_I_LW: begin
                // I-type (算數 / load)
                immed_o = imm_i;
            end
            `OPC_S: begin
                // S-type (store)
                immed_o = imm_s;
            end
            `OPC_SB: begin
                // SB-type (branch)
                immed_o = imm_sb;
            end
            default: begin
                // 不支持的 opcode：default
                immed_o = imm_i;
            end
        endcase
    end

endmodule
