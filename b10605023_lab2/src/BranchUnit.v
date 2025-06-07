`timescale 1ns/1ps

module BranchUnit (
    input  wire [31:0] offset_i,
    input  wire [31:0] pc_i,
    input  wire [31:0] op1_i,
    input  wire [31:0] op2_i,
    input  wire        branch_en_i,
    output wire [31:0] target_pc_o,
    output wire        take_branch_o
);

    // 分支address：pc + (offset << 1)
    assign target_pc_o  = pc_i + (offset_i << 1);

    // 當 branch_en_i 有效且比較相等時才跳轉
    assign take_branch_o = branch_en_i & (op1_i == op2_i);

endmodule
