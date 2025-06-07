module Forwarder (
    input  [4:0] EX_Rs1_i,  // Source register 1 in EX stage
    input  [4:0] EX_Rs2_i,  // Source register 2 in EX stage
    input        MEM_RegWrite_i, // MEM stage RegWrite
    input  [4:0] MEM_Rd_i, // Destination register in MEM stage
    input        WB_RegWrite_i,  // WB stage RegWrite
    input  [4:0] WB_Rd_i,  // Destination register in WB stage
    output reg [1:0] Forward_A_o, // Forward control for operand A
    output reg [1:0] Forward_B_o  // Forward control for operand B
);

    // Forwarding encoding:
    // 2'b00: no forwarding (use EX stage value)
    // 2'b01: forward from WB stage
    // 2'b10: forward from MEM stage

    always @* begin
        // Default: no forwarding
        Forward_A_o = 2'b00;
        Forward_B_o = 2'b00;

        // Check EX_Rs1 dependency
        if (MEM_RegWrite_i && (MEM_Rd_i != 5'd0) && (MEM_Rd_i == EX_Rs1_i)) begin
            Forward_A_o = 2'b10;
        end else if (WB_RegWrite_i && (WB_Rd_i != 5'd0) && (WB_Rd_i == EX_Rs1_i)) begin
            Forward_A_o = 2'b01;
        end

        // Check EX_Rs2 dependency
        if (MEM_RegWrite_i && (MEM_Rd_i != 5'd0) && (MEM_Rd_i == EX_Rs2_i)) begin
            Forward_B_o = 2'b10;
        end else if (WB_RegWrite_i && (WB_Rd_i != 5'd0) && (WB_Rd_i == EX_Rs2_i)) begin
            Forward_B_o = 2'b01;
        end
    end

endmodule
