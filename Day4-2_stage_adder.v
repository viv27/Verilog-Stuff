// 1. Fixed Full Adder Module
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire sum1, carry1, carry2; // Fixed typo: 'carr1' changed to 'carry1'
    
    assign sum1   = a ^ b;
    assign carry1 = a & b;
    assign sum    = sum1 ^ cin;
    assign carry2 = cin & sum1;
    assign cout   = carry1 | carry2; 
endmodule


// 2. Fixed 2-Stage Pipelined Adder Module
module pipelined_adder_2stage (
    input clk,                    // Added clock for stage boundaries
    input rst_n,                  // Added active-low synchronous reset
    input [1:0] A,                // Standardized bit ordering to [1:0]
    input [1:0] B,
    output reg [2:0] total_sum    // Bit [2] is the final carry-out
);

    // -------------------------------------------------------------------------
    // STAGE 1: Calculate LSB Addition & Register intermediate data
    // -------------------------------------------------------------------------
    wire sum0_wire;
    wire c0_wire;
    
    // Instantiating the LSB adder (Stage 1 logic)
    full_adder FA0 (
        .a(A[0]),
        .b(B[0]),
        .cin(1'b0),
        .sum(sum0_wire),
        .cout(c0_wire) // This carry must be registered before reaching Stage 2
    );

    // Stage 1 -> Stage 2 Pipeline Registers
    reg r_sum0;
    reg r_c0;
    reg r_a1, r_b1;

    always @(posedge clk) begin
        if (!rst_n) begin
            r_sum0 <= 1'b0;
            r_c0   <= 1'b0;
            r_a1   <= 1'b0;
            r_b1   <= 1'b0;
        end else begin
            r_sum0 <= sum0_wire; // Save LSB sum
            r_c0   <= c0_wire;   // Save intermediate carry-out
            r_a1   <= A[1];      // Pipeline MSB of A
            r_b1   <= B[1];      // Pipeline MSB of B
        end
    end

    // -------------------------------------------------------------------------
    // STAGE 2: Calculate MSB Addition using registered data
    // -------------------------------------------------------------------------
    wire sum1_wire;
    wire c1_wire;

    // Instantiating the MSB adder (Stage 2 logic) using pipelined registers
    full_adder FA1 (
        .a(r_a1),
        .b(r_b1),
        .cin(r_c0),
        .sum(sum1_wire),
        .cout(c1_wire)
    );

    // Final Output Register
    always @(posedge clk) begin
        if (!rst_n) begin
            total_sum <= 3'b000;
        end else begin
            // Concatenate: Final Carry-out, MSB sum, LSB sum
            total_sum <= {c1_wire, sum1_wire, r_sum0};
        end
    end

endmodule