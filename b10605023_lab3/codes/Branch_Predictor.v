`define STRONGLY_NON_TAKEN 2'b00
`define WEAKLY_NON_TAKEN   2'b01
`define WEAKLY_TAKEN       2'b10
`define STRONGLY_TAKEN     2'b11

module Branch_Predictor (
    input        clk_i,
    input        rst_i,         // active-low reset
    input        EX_Branch_i,   // is EX stage executing a branch?
    input        EX_gtTaken_i,  // at EX stage, should it be taken?
    output       predict_o      // current prediction: 1 = taken, 0 = not taken
);

    reg [1:0] state;

    assign predict_o = state[1];

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            state <= `STRONGLY_TAKEN;
        end
        else if (EX_Branch_i) begin
            case (state)
                `STRONGLY_TAKEN: begin
                    if (!EX_gtTaken_i)
                        state <= `WEAKLY_TAKEN;
                end

                `WEAKLY_TAKEN: begin
                    state <= EX_gtTaken_i
                             ? `STRONGLY_TAKEN
                             : `WEAKLY_NON_TAKEN;
                end

                `WEAKLY_NON_TAKEN: begin
                    state <= EX_gtTaken_i
                             ? `WEAKLY_TAKEN
                             : `STRONGLY_NON_TAKEN;
                end

                `STRONGLY_NON_TAKEN: begin
                    if (EX_gtTaken_i)
                        state <= `WEAKLY_NON_TAKEN;
                end

                default: begin
                    state <= `STRONGLY_TAKEN;  // safety fallback
                end
            endcase
        end
    end

endmodule
