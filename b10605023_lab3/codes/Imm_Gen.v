`define I_TYPE_ALU 7'b0010011
`define I_TYPE_LW  7'b0000011 // lw
`define S_TYPE     7'b0100011 // sw
`define SB_TYPE    7'b1100011 // beq

module Imm_Gen (
    instr_i,
    immed_o
);
    input  [31:0] instr_i;
    output reg [11:0] immed_o;

    // Generate immediate based on instruction format
    always @* begin
        case (instr_i[6:0])
            `I_TYPE_ALU,
            `I_TYPE_LW: begin
                // I-type and load use bits [31:20]
                immed_o = instr_i[31:20];
            end

            `S_TYPE: begin
                // S-type split: [31:25] concatenated with [11:7]
                immed_o = { instr_i[31:25], instr_i[11:7] };
            end

            `SB_TYPE: begin
                // SB-type: sign, bit7, bits[30:25], bits[11:8]
                immed_o = { instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8] };
            end

            default: begin
                // For unsupported opcodes, output zero
                immed_o = 12'd0;
            end
        endcase
    end
endmodule