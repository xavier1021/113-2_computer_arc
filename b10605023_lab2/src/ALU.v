`timescale 1ns/1ps

`define AND   3'b000
`define XOR   3'b001
`define SLL   3'b010
`define ADD   3'b011
`define SUB   3'b100
`define MUL   3'b101
`define ADDI  3'b110
`define SRAI  3'b111

module ALU (
    input  wire [31:0] src1_i,
    input  wire [31:0] src2_i,
    input  wire [2:0]  ALUCtr_i,
    output reg  [31:0] res_o,
    output wire        zero
);

    // zero flag
    assign zero = (res_o == 32'd0);

    // 一次在一個always里完成
    always @(*) begin
        case (ALUCtr_i)
            `AND:   res_o = src1_i &  src2_i;
            `XOR:   res_o = src1_i ^  src2_i;
            `SLL:   res_o = src1_i << src2_i[4:0];
            `ADD,
            `ADDI:  res_o = src1_i +  src2_i;
            `SUB:   res_o = src1_i -  src2_i;
            `MUL:   res_o = src1_i *  src2_i;
            `SRAI:  // 右移，需 signed
                res_o = $signed(src1_i) >>> src2_i[4:0];
            default:
                res_o = 32'h0000_0000; // 默认 0
        endcase
    end

endmodule
