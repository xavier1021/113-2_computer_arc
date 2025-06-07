module Pipeline_EX_MEM (
    input             clk_i,         // clock
    input             rst_i,         // active-low reset

    // Inputs from EX stage
    input  [31:0]     ALUout_i,
    input  [31:0]     WriteData_i,
    input  [4:0]      Rd_i,
    input             RegWrite_i,
    input             MemtoReg_i,
    input             MemRead_i,
    input             MemWrite_i,

    // Outputs to MEM stage
    output reg [31:0] ALUout_o,
    output reg [31:0] WriteData_o,
    output reg [4:0]  Rd_o,
    output reg        RegWrite_o,
    output reg        MemtoReg_o,
    output reg        MemRead_o,
    output reg        MemWrite_o
);

    // On reset, clear all pipeline registers, else latch inputs
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            ALUout_o    <= 32'd0;
            WriteData_o <= 32'd0;
            Rd_o        <= 5'd0;
            RegWrite_o  <= 1'b0;
            MemtoReg_o  <= 1'b0;
            MemRead_o   <= 1'b0;
            MemWrite_o  <= 1'b0;
        end else begin
            ALUout_o    <= ALUout_i;
            WriteData_o <= WriteData_i;
            Rd_o        <= Rd_i;
            RegWrite_o  <= RegWrite_i;
            MemtoReg_o  <= MemtoReg_i;
            MemRead_o   <= MemRead_i;
            MemWrite_o  <= MemWrite_i;
        end
    end

endmodule