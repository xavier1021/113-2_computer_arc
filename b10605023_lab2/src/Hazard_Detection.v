`timescale 1ns/1ps

module Hazard_Detection (
    input  wire [4:0] ID_Rs1_i,
    input  wire [4:0] ID_Rs2_i,
    input  wire       EX_MemRead_i,
    input  wire [4:0] EX_Rd_i,
    output reg        NoOp_o,
    output reg        PCWrite_o,
    output reg        Stall_o
);

    always @(*) begin
        // default：不插入 bubble，PC 正常寫入，不stall
        NoOp_o     = 1'b0;
        PCWrite_o  = 1'b1;
        Stall_o    = 1'b0;

        // load-use hazard: EX stage 正在讀內存且目標正被後續指令使用
        if (EX_MemRead_i && ((EX_Rd_i == ID_Rs1_i) || (EX_Rd_i == ID_Rs2_i))) begin
            NoOp_o     = 1'b1;
            PCWrite_o  = 1'b0;
            Stall_o    = 1'b1;
        end
    end

endmodule
