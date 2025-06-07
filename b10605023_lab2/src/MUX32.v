`timescale 1ns/1ps

module MUX32 (
    input  wire [31:0] src0_i,
    input  wire [31:0] src1_i,
    input  wire        select_i,
    output reg  [31:0] res_o
);

    always @(*) begin
        if (select_i == 1'b0) begin
            res_o = src0_i;
        end
        else begin
            res_o = src1_i;
        end
    end

endmodule
