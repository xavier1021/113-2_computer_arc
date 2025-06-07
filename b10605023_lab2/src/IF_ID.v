`timescale 1ns/1ps

module IF_ID (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire [31:0] instr_i,
    input  wire [31:0] pc_i,
    input  wire        Flush_i,
    input  wire        Stall_i,
    output reg  [31:0] instr_o,
    output reg  [31:0] pc_o
);

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            // 輸出寄存器清零
            pc_o    <= 32'd0;
            instr_o <= 32'd0;
        end
        else if (Stall_i) begin
            // 流水縣stall：保留old value，不做任何更新
            pc_o    <= pc_o;
            instr_o <= instr_o;
        end
        else if (Flush_i) begin
            // 分支 Flush：插入泡沫，置零
            pc_o    <= 32'd0;
            instr_o <= 32'd0;
        end
        else begin
            // 正常流水線推進：更新成 IF 结果
            pc_o    <= pc_i;
            instr_o <= instr_i;
        end
    end

endmodule
