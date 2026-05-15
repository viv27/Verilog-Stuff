`timescale 1ns/1ps

module tb_pipelined_adder_2stage;

    // 1. Declare inputs to the design as registers (reg)
    reg clk;
    reg rst_n;
    reg [1:0] A;
    reg [1:0] B;

    // 2. Declare outputs from the design as wires
    wire [2:0] total_sum;

    // 3. Instantiate the Unit Under Test (UUT)
    pipelined_adder_2stage uut (
        .clk(clk),
        .rst_n(rst_n),
        .A(A),
        .B(B),
        .total_sum(total_sum)
    );

    // 4. Clock Generator (100MHz clock frequency -> 10ns full period)
    // Toggles every 5ns
    always begin
        #5 clk = ~clk;
    end

    // 5. Stimulus Block
    initial begin
        // Initialize all inputs to a safe, known state at Time = 0
        clk = 0;
        rst_n = 0; // Assert reset immediately
        A = 2'b00;
        B = 2'b00;

        // Hold reset active for 2 full clock cycles
        #20; 
        
        // Synchronize our input changes to the falling edge of the clock
        @(negedge clk);
        rst_n = 1; // Release reset cleanly 

        // --- CYCLE 1 ---
        // Problem 1: 3 + 1 = 4 (Binary: 2'b11 + 2'b01 = 3'b100)
        A = 2'b11; B = 2'b01; 
        @(negedge clk); // Wait for the next falling edge

        // --- CYCLE 2 ---
        // Problem 2: 2 + 2 = 4 (Binary: 2'b10 + 2'b10 = 3'b100)
        // Note: total_sum is still 000 right now because Problem 1 is in Stage 1
        A = 2'b10; B = 2'b10; 
        @(negedge clk);

        // --- CYCLE 3 ---
        // Problem 3: 1 + 1 = 2 (Binary: 2'b01 + 2'b01 = 3'b010)
        // Note: The result for Problem 1 (total_sum = 4) emerges right at the 
        // beginning of this cycle (on the rising edge).
        A = 2'b01; B = 2'b01; 
        @(negedge clk);

        // --- CYCLE 4 ---
        // Clear the inputs to zero.
        // Note: The result for Problem 2 (total_sum = 4) emerges here.
        A = 2'b00; B = 2'b00; 
        @(negedge clk);

        // --- CYCLE 5 ---
        // Let the final calculation finish processing.
        // Note: The result for Problem 3 (total_sum = 2) emerges here.
        @(negedge clk);

        // End simulation safely
        $display("Simulation complete.");
        $finish;
    end

    // 6. Output Monitoring Block
    initial begin
        $monitor("Time=%0t ns | rst_n=%b | A=%d B=%d | Output total_sum=%d (Binary: %b)", 
                 $time, rst_n, A, B, total_sum, total_sum);
    end

endmodule