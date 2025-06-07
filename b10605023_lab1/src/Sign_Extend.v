module Sign_Extend (
    input  [31:0] data_i,
    output [31:0] data_o
);
    assign data_o = {{20{data_i[31]}}, data_i[31:20]};
endmodule
