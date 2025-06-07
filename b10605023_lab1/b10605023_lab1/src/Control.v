module Control (
    input  [6:0] Op_i,
    output       ALUSrc_o,
    output [1:0] ALUOp_o,
    output       RegWrite_o
);
    reg ALUSrc;
    reg [1:0] ALUOp;
    reg RegWrite;

    always @(*) begin
        case (Op_i)
            7'b0110011: begin // R-type
                ALUSrc   = 0;
                ALUOp    = 2'b10;
                RegWrite = 1;
            end
            7'b0010011: begin // I-type (addi, srai)
                ALUSrc   = 1;
                ALUOp    = 2'b11;
                RegWrite = 1;
            end
            default: begin
                ALUSrc   = 0;
                ALUOp    = 2'b00;
                RegWrite = 0;
            end
        endcase
    end

    assign ALUSrc_o   = ALUSrc;
    assign ALUOp_o    = ALUOp;
    assign RegWrite_o = RegWrite;
endmodule
