`timescale 1ns/1ps

module MEM_WB (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire [31:0] MemoryData_i,
    input  wire [31:0] ALUout_i,
    input  wire [4:0]  Rd_i,
    input  wire        RegWrite_i,
    input  wire        MemtoReg_i,

    output reg  [31:0] MemoryData_o,
    output reg  [31:0] ALUout_o,
    output reg  [4:0]  Rd_o,
    output reg         RegWrite_o,
    output reg         MemtoReg_o
);

    // 打包所有输出寄存器以便批量复位/更新
    reg [69:0] pipeline_regs; // 32+32+5+1+1 = 71 位

    wire [31:0] mem_d_in  = MemoryData_i;
    wire [31:0] alu_o_in  = ALUout_i;
    wire [4:0]  rd_in     = Rd_i;
    wire        rw_in     = RegWrite_i;
    wire        m2r_in    = MemtoReg_i;

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            // 一起清０
            MemoryData_o <= 32'd0;
            ALUout_o     <= 32'd0;
            Rd_o         <= 5'd0;
            RegWrite_o   <= 1'b0;
            MemtoReg_o   <= 1'b0;
        end
        else begin
            // 正常pass
            MemoryData_o <= mem_d_in;
            ALUout_o     <= alu_o_in;
            Rd_o         <= rd_in;
            RegWrite_o   <= rw_in;
            MemtoReg_o   <= m2r_in;
        end
    end

endmodule
