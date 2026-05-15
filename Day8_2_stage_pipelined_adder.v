module full_adder(

    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire carry1,carry2,sum1;
    assign sum1   = a ^ b;
    assign carry1 = a & b;
    assign sum    = sum1 ^ cin;
    assign carry2 = cin & sum1;
    assign cout  = carry1 | carry2;

endmodule


module pipelined_adder_2stage(

    input clk,
    input rst_n,
    input [1:0] A,
    input [1:0] B,
    output reg [2:0] total_sum
    );

// Stage 1 : Calculate LSB addition and register intermediate data

wire sum0_wire;
wire c0_wire;

full_adder FA0(
    .a(A[0]),
    .b(B[0]),
    .cin(1'b0),
    .sum(sum0_wire),
    .cout(c0_wire)
);


reg r_sum0;
reg r_c0;
reg r_a1,r_b1;

always @(posedge clk) begin
    if(!rst_n) begin
        r_sum0 <= 1'b0;
        r_c0 <= 1'b0;
        r_a1 <= 1'b0;
        r_b1 <= 1'b0;
    end else begin
        r_sum0 <= sum0_wire;
        r_c0 <= c0_wire;
        r_a1 <= A[1]; // pipeline MSB of A
        r_b1 <= B[1]; // pipeline MSB of A
    end
end


//Stage 2 : Calculate MSB addition 

wire sum1_wire;
wire c1_wire;

full_adder FA1(
    .a(r_a1),
    .b(r_b1),
    .cin(r_c0),
    .sum(sum1_wire),
    .cout(c1_wire)
);

always @(posedge clk) begin
    if(!rst_n) begin
        total_sum <= 3'b000;
    end else begin
        total_sum <= {c1_wire,sum1_wire,r_sum0};
    end
    
end

endmodule