`timescale 1ns/1ps

module Forwarder(
    input  wire [4:0] EX_Rs1_i,
    input  wire [4:0] EX_Rs2_i,
    input  wire       MEM_RegWrite_i,
    input  wire [4:0] MEM_Rd_i,
    input  wire       WB_RegWrite_i,
    input  wire [4:0] WB_Rd_i,
    output reg  [1:0] Forward_A_o,
    output reg  [1:0] Forward_B_o
);

    always @(*) begin

        Forward_A_o = 2'b00;
        Forward_B_o = 2'b00;

        // MEM 優先，WB 次之
        if (MEM_RegWrite_i && (MEM_Rd_i != 5'd0) && (MEM_Rd_i == EX_Rs1_i)) begin
            Forward_A_o = 2'b10;
        end
        else if (WB_RegWrite_i && (WB_Rd_i != 5'd0) && (WB_Rd_i == EX_Rs1_i)) begin
            Forward_A_o = 2'b01;
        end

        // 同理
        if (MEM_RegWrite_i && (MEM_Rd_i != 5'd0) && (MEM_Rd_i == EX_Rs2_i)) begin
            Forward_B_o = 2'b10;
        end
        else if (WB_RegWrite_i && (WB_Rd_i != 5'd0) && (WB_Rd_i == EX_Rs2_i)) begin
            Forward_B_o = 2'b01;
        end
    end

endmodule
