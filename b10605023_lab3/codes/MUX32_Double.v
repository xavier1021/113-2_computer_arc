module MUX32_Double (
    input  [31:0] src00_i, // select = 00
    input  [31:0] src01_i, // select = 01
    input  [31:0] src10_i, // select = 10
    input  [31:0] src11_i, // select = 11
    input  [1:0]  select_i,
    output reg [31:0] res_o
);

    // 4-to-1 multiplexer for 32-bit inputs
    always @(*) begin
        case (select_i)
            2'b00: res_o = src00_i; // choose input 00
            2'b01: res_o = src01_i; // choose input 01
            2'b10: res_o = src10_i; // choose input 10
            2'b11: res_o = src11_i; // choose input 11
            default: begin
                // should never happen: set to unknown for safety
                res_o = 32'hXXXX_XXXX;
            end
        endcase
    end

endmodule