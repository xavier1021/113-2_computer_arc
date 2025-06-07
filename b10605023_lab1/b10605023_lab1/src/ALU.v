module ALU (
    input  [31:0] data1_i,
    input  [31:0] data2_i,
    input  [3:0]  ALUCtrl_i,
    output reg [31:0] data_o,
    output        Zero_o
);

always @(*) begin
    case(ALUCtrl_i)
        4'b0010: data_o = data1_i + data2_i; // add, addi
        4'b0110: data_o = data1_i - data2_i; // sub
        4'b0000: data_o = data1_i & data2_i; // and
        4'b0001: data_o = data1_i ^ data2_i; // xor
        4'b1000: data_o = data1_i << data2_i[4:0]; // sll
        4'b1001: data_o = data1_i * data2_i; // mul
        4'b1010: data_o = data1_i >>> data2_i[4:0]; // srai
        default: data_o = 32'b0;
    endcase
end

assign Zero_o = (data_o == 0);

endmodule
