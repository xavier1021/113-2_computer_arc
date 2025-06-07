`timescale 1ns/1ps

module MUX32_Double(
    input  wire [1:0]  select_i,
    input  wire [31:0] src00_i,
    input  wire [31:0] src01_i,
    input  wire [31:0] src10_i,
    input  wire [31:0] src11_i,
    output reg  [31:0] res_o
);

    // Combinational multiplexer
    always @(*) begin
        // 輸出第一个輸入
        res_o = src00_i;

        // 根據 select_i 選擇
        if      (select_i == 2'b01) res_o = src01_i;
        else if (select_i == 2'b10) res_o = src10_i;
        else if (select_i == 2'b11) res_o = src11_i;
        // select_i == 2'b00 保持 src00_i
    end

endmodule
