`timescale 1ns/1ps

module EX_MEM (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire [31:0] ALUout_i,
    input  wire [31:0] WriteData_i,
    input  wire [4:0]  Rd_i,
    input  wire        RegWrite_i,
    input  wire        MemtoReg_i,
    input  wire        MemRead_i,
    input  wire        MemWrite_i,

    output reg  [31:0] ALUout_o,
    output reg  [31:0] WriteData_o,
    output reg  [4:0]  Rd_o,
    output reg         RegWrite_o,
    output reg         MemtoReg_o,
    output reg         MemRead_o,
    output reg         MemWrite_o
);

    // 同步復位/傳遞寄存器
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            // 低復位：全部清零
            ALUout_o     <= 32'd0;
            WriteData_o  <= 32'd0;
            Rd_o         <= 5'd0;
            RegWrite_o   <= 1'b0;
            MemtoReg_o   <= 1'b0;
            MemRead_o    <= 1'b0;
            MemWrite_o   <= 1'b0;
        end
        else begin
            // 正常流水線傳遞
            ALUout_o     <= ALUout_i;
            WriteData_o  <= WriteData_i;
            Rd_o         <= Rd_i;
            RegWrite_o   <= RegWrite_i;
            MemtoReg_o   <= MemtoReg_i;
            MemRead_o    <= MemRead_i;
            MemWrite_o   <= MemWrite_i;
        end
    end

endmodule
