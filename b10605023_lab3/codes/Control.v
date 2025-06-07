`define R_TYPE      7'b0110011
`define I_TYPE_ALU  7'b0010011
`define I_TYPE_LW   7'b0000011
`define S_TYPE      7'b0100011
`define SB_TYPE     7'b1100011

module Control (
    Op_i,
    NoOp_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    Branch_o
);
    input  [6:0] Op_i;
    input        NoOp_i;

    output reg [1:0] ALUOp_o;
    output reg       ALUSrc_o;
    output reg       RegWrite_o;
    output reg       MemtoReg_o;
    output reg       MemRead_o;
    output reg       MemWrite_o;
    output reg       Branch_o;

    // combinational control signals
    always @(*) begin
        // default: all control signals deasserted
        ALUOp_o    = 2'b00;
        ALUSrc_o   = 1'b0;
        RegWrite_o = 1'b0;
        MemtoReg_o = 1'b0;
        MemRead_o  = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o   = 1'b0;

        // override defaults if not a NoOp
        if (!NoOp_i) begin
            case (Op_i)
                `R_TYPE: begin
                    ALUOp_o    = 2'b10;
                    RegWrite_o = 1'b1;
                end

                `I_TYPE_ALU: begin
                    ALUOp_o    = 2'b11;
                    ALUSrc_o   = 1'b1;
                    RegWrite_o = 1'b1;
                end

                `I_TYPE_LW: begin
                    ALUOp_o    = 2'b01;  // ADD for address calc
                    ALUSrc_o   = 1'b1;
                    RegWrite_o = 1'b1;
                    MemtoReg_o = 1'b1;
                    MemRead_o  = 1'b1;
                end

                `S_TYPE: begin
                    ALUOp_o    = 2'b01;  // ADD for store address
                    ALUSrc_o   = 1'b1;
                    MemWrite_o = 1'b1;
                end

                `SB_TYPE: begin
                    ALUOp_o    = 2'b00;  // SUB for branch comparison
                    Branch_o   = 1'b1;
                end

                default: begin
                    // leave defaults
                end
            endcase
        end
    end
endmodule
