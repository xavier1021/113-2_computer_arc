module Sign_Extend(data_i, data_o);
    input [11:0] data_i;// 12-bit immediate
    output [31:0] data_o; // sign-extended 32-bit output

    assign data_o[31:12] = {20{data_i[11]}};
    assign data_o[11:0] = data_i;

endmodule