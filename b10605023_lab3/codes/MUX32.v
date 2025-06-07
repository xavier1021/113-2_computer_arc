module MUX32 (
    input  [31:0] src0_i,  // input when select_i = 0
    input  [31:0] src1_i,  // input when select_i = 1
    input         select_i,// 0: choose src0_i; 1: choose src1_i
    output reg [31:0] res_o // output result
);

    // Use combinational logic for clarity
    always @(*) begin
        if (select_i == 1'b0) begin
            res_o = src0_i;
        end else begin
            res_o = src1_i;
        end
    end

endmodule