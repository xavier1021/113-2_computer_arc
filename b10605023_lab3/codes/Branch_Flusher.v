module Branch_Flusher (
    ID_predict_i,
    ID_Branch_i,
    EX_Branch_i,
    EX_predict_i,
    EX_zero_i,
    IF_ID_flush_o,
    ID_EX_flush_o,
    next_pc_select_o
);

    input  ID_predict_i;
    input  ID_Branch_i;
    input  EX_Branch_i;
    input  EX_predict_i;
    input  EX_zero_i;

    output reg        IF_ID_flush_o;
    output reg        ID_EX_flush_o;
    output reg [1:0]  next_pc_select_o;

    // helper signals
    wire ID_taken = ID_predict_i & ID_Branch_i;       // predicted taken in ID
    wire EX_mispred = (EX_predict_i ^ EX_zero_i);     // prediction mismatch at EX

    always @(*) begin
        // default behavior: no EX flush, use ID prediction
        IF_ID_flush_o      = ID_taken;
        ID_EX_flush_o      = 1'b0;
        next_pc_select_o   = ID_taken ? 2'b01      // ID predicted taken
                                       : 2'b00;     // ID predicted not taken

        // override on misprediction at EX stage
        if (EX_Branch_i && EX_mispred) begin
            IF_ID_flush_o    = 1'b1;
            ID_EX_flush_o    = 1'b1;
            next_pc_select_o = EX_predict_i
                                ? 2'b10         // was predicted taken → go to default PC
                                : 2'b11;        // was predicted not taken → go to branch PC
        end
    end

endmodule
