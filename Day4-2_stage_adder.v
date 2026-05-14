module full_adder
(
input a,
input b,
input cin,
output sum,
output cout

);

wire sum1, carr1,carry2;
assign sum1 = a ^ b;
assign carry1 = a & b;
assign sum = sum1 ^ cin;
assign carry2 = cin & sum1;
assign cout = carry1 | carry2; 

endmodule


module 2_stage_adder(

input [0:1]A;
input [0:1]B;
output [0:1]sum;
output cin;


);


wire c0;
full_adder FA0(
    .a(A[0]);
    .b(B[0]);
    .cin(1'b0);
    .sum(sum[0]);
    .cout(c0)
);

full_adder FA1(
    .a(A[1]);
    .b(B[1]);
    .cin();
    .sum(sum[0]);
    .cout(c0)
);