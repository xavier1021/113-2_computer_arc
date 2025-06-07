module Hazard_Detection (
    input  [4:0] ID_Rs1_i,    // Source register 1 in ID stage
    input  [4:0] ID_Rs2_i,    // Source register 2 in ID stage
    input        EX_MemRead_i, // MEM stage MemRead signal
    input  [4:0] EX_Rd_i,     // Destination register in EX stage
    output reg   NoOp_o,      // Insert bubble signal
    output reg   PCWrite_o,   // PC write enable
    output reg   Stall_o      // Pipeline stall signal
);

    always @* begin
        // Default: no hazard, normal operation
        NoOp_o    = 1'b0;
        PCWrite_o = 1'b1;
        Stall_o   = 1'b0;

        // Detect load-use hazard: EX stage is reading from memory and its destination
        // matches one of the source registers in ID stage
        if (EX_MemRead_i && ((EX_Rd_i == ID_Rs1_i) || (EX_Rd_i == ID_Rs2_i))) begin
            NoOp_o    = 1'b1; // insert bubble
            PCWrite_o = 1'b0; // freeze PC
            Stall_o   = 1'b1; // stall pipeline
        end
    end

endmodule