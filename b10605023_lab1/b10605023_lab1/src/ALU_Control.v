module ALU_Control (
    input  [1:0] ALUOp_i,
    input  [2:0] Funct3_i,
    input  [6:0] Funct7_i,
    output reg [3:0] ALUCtrl_o
);

always @(*) begin
    case (ALUOp_i)
        2'b10: begin // R-type
            case ({Funct7_i, Funct3_i})
                10'b0000000000: ALUCtrl_o = 4'b0010; // add
                10'b0100000000: ALUCtrl_o = 4'b0110; // sub
                10'b0000000111: ALUCtrl_o = 4'b0000; // and
                10'b0000000100: ALUCtrl_o = 4'b0001; // xor
                10'b0000000001: ALUCtrl_o = 4'b1000; // sll
                10'b0000001000: ALUCtrl_o = 4'b1001; // mul
                default:        ALUCtrl_o = 4'b1111;
            endcase
        end
        2'b11: begin // I-type
            case (Funct3_i)
                3'b000: ALUCtrl_o = 4'b0010; // addi
                3'b101: ALUCtrl_o = 4'b1010; // srai
                default: ALUCtrl_o = 4'b1111;
            endcase
        end
        default: ALUCtrl_o = 4'b1111;
    endcase
end

endmodule
