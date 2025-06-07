module Pipeline_MEM_WB (
    input             clk_i,         // clock
    input             rst_i,         // active-low reset

    // Inputs from MEM stage
    input  [31:0]     ALUout_i,      // ALU result
    input  [31:0]     MemoryData_i,  // Data read from memory
    input  [4:0]      Rd_i,          // Destination register address
    input             RegWrite_i,    // Register write enable
    input             MemtoReg_i,    // Select memory data vs ALU result

    // Outputs to WB stage
    output reg [31:0] ALUout_o,
    output reg [31:0] MemoryData_o,
    output reg [4:0]  Rd_o,
    output reg        RegWrite_o,
    output reg        MemtoReg_o
);

    // On reset, clear all outputs; otherwise latch inputs on clock
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            ALUout_o      <= 32'd0;
            MemoryData_o  <= 32'd0;
            Rd_o          <= 5'd0;
            RegWrite_o    <= 1'b0;
            MemtoReg_o    <= 1'b0;
        end else begin
            ALUout_o      <= ALUout_i;
            MemoryData_o  <= MemoryData_i;
            Rd_o          <= Rd_i;
            RegWrite_o    <= RegWrite_i;
            MemtoReg_o    <= MemtoReg_i;
        end
    end

endmodule