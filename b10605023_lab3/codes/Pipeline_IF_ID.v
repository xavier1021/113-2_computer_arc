module Pipeline_IF_ID (
    input             clk_i,         // clock
    input             rst_i,         // active-low reset
    input      [31:0] instr_i,       // instruction fetched
    input      [31:0] pc_i,          // PC of fetched instruction
    input             flush_i,       // flush signal
    input             Stall_i,       // stall signal

    input      [31:0] pc_default_i,  // default PC for next IF

    output reg [31:0] instr_o,       // output to ID stage
    output reg [31:0] pc_o,
    output reg [31:0] pc_default_o
);

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i || flush_i) begin
            // clear all outputs on reset or flush
            instr_o      <= 32'd0;
            pc_o         <= 32'd0;
            pc_default_o <= 32'd0;
        end
        else if (!Stall_i) begin
            // latch inputs when not stalled
            instr_o      <= instr_i;
            pc_o         <= pc_i;
            pc_default_o <= pc_default_i;
        end
        // else: Stall_i = 1, hold previous values
    end

endmodule