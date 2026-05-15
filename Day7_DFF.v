//synchronous D flip-flop with  reset

module DFF(
    input clk,
    input reset,
    output reg q,
    input d
);
    always @(posedge clk) begin
        
        if(reset)
            q <= 0;
        else
            q <= d; 
    end
endmodule


//asynchronous D flip-flop with reset

module DFF2(
    input clk,
    input reset,
    input d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        
        if(reset)
            q <= 0;
        else
            q <= d;
    end
endmodule

module tb_DFF;
    reg clk;
    reg reset;
    reg d;
    wire q;

    DFF2 uut (.clk(clk),.reset(reset),.d(d), .q(q));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        $monitor("clk = %b reset = %b  d= %b  q = %b",clk,reset,d,q);
        // normal operation
        reset = 0; d = 1; #20;
        
        // async reset — fires immediately, no waiting for clock
        reset = 1; #7;
        
        // release reset
        reset = 0; d = 1; #20;
        $finish;
    end
endmodule
