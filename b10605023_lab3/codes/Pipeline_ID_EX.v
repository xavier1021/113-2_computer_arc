module Pipeline_ID_EX (
    input             clk_i,          // clock
    input             rst_i,          // active-low reset

    // Data inputs from ID stage
    input      [31:0] RS1data_i,
    input      [31:0] RS2data_i,
    input      [31:0] immed_i,
    input      [31:0] pc_i,
    input      [31:0] instr_i,

    // Control and address inputs
    input      [4:0]  Rd_i,
    input      [1:0]  ALUOp_i,
    input             ALUSrc_i,
    input             RegWrite_i,
    input             MemtoReg_i,
    input             MemRead_i,
    input             MemWrite_i,
    input      [4:0]  RS1addr_i,
    input      [4:0]  RS2addr_i,

    // Branch & prediction signals
    input             flush_i,
    input             Branch_i,
    input             Predict_i,
    input      [31:0] pc_branch_i,
    input      [31:0] pc_default_i,

    // Outputs to EX stage
    output reg [31:0] RS1data_o,
    output reg [31:0] RS2data_o,
    output reg [31:0] immed_o,
    output reg [31:0] pc_o,
    output reg [31:0] instr_o,
    output reg [4:0]  Rd_o,
    output reg [1:0]  ALUOp_o,
    output reg        ALUSrc_o,
    output reg        RegWrite_o,
    output reg        MemtoReg_o,
    output reg        MemRead_o,
    output reg        MemWrite_o,
    output reg [4:0]  RS1addr_o,
    output reg [4:0]  RS2addr_o,
    output reg        Branch_o,
    output reg        Predict_o,
    output reg [31:0] pc_branch_o,
    output reg [31:0] pc_default_o
);

    // On reset or flush, clear pipeline regs; else latch inputs
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i || flush_i) begin
            RS1data_o    <= 32'd0;
            RS2data_o    <= 32'd0;
            immed_o      <= 32'd0;
            pc_o         <= 32'd0;
            instr_o      <= 32'd0;
            Rd_o         <= 5'd0;
            ALUOp_o      <= 2'd0;
            ALUSrc_o     <= 1'b0;
            RegWrite_o   <= 1'b0;
            MemtoReg_o   <= 1'b0;
            MemRead_o    <= 1'b0;
            MemWrite_o   <= 1'b0;
            RS1addr_o    <= 5'd0;
            RS2addr_o    <= 5'd0;
            Branch_o     <= 1'b0;
            Predict_o    <= 1'b0;
            pc_branch_o  <= 32'd0;
            pc_default_o <= 32'd0;
        end else begin
            RS1data_o    <= RS1data_i;
            RS2data_o    <= RS2data_i;
            immed_o      <= immed_i;
            pc_o         <= pc_i;
            instr_o      <= instr_i;
            Rd_o         <= Rd_i;
            ALUOp_o      <= ALUOp_i;
            ALUSrc_o     <= ALUSrc_i;
            RegWrite_o   <= RegWrite_i;
            MemtoReg_o   <= MemtoReg_i;
            MemRead_o    <= MemRead_i;
            MemWrite_o   <= MemWrite_i;
            RS1addr_o    <= RS1addr_i;
            RS2addr_o    <= RS2addr_i;
            Branch_o     <= Branch_i;
            Predict_o    <= Predict_i;
            pc_branch_o  <= pc_branch_i;
            pc_default_o <= pc_default_i;
        end
    end
endmodule
