module NAND_2_1_MUX(
    input A,
    input B,
    output Y
);

assign Y = B ? ~A : 1'b1;

endmodule

module tb_nand_mux;
    reg A,B;
    wire Y;

    NAND_2_1_MUX uut (.A(A),.B(B),.Y(Y));

    initial begin
        $monitor("A=%b B=%b Y=%b",A,B,Y);
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;
        $finish;
    end
endmodule



