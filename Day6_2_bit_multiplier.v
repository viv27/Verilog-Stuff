module multiplier_2_bit(

    input [1:0] A,
    input [1:0] B,
    output [3:0] out
);

wire [1:0] pp1,pp2;

assign pp1 = A & {2{B[0]}} ;
assign pp2 = A &  {2{B[1]}};


assign out = pp1 + (pp2 << 1);

endmodule


module tb_multiplier_2_bit;
    reg [1:0] A,B;
    wire [3:0] out;
    multiplier_2_bit uut (.A(A),.B(B),.out(out));
    initial begin
        $monitor("A = %b B = %b out = %b",A,B,out);
        A = 2'b11; B = 2'b10;#10
        A = 2'b11; B = 2'b11; #10;
        $finish;
    end


endmodule
