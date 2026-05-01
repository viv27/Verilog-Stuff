// Write 4-to-1 mux mux4. Inputs a, b, c, d (1-bit each),
// sel[1:0]. Output reg y. Use case. sel=0→a, sel=1→b, sel=2→c, sel=3→d.


module Mux4(input a,b,c,d,input[1:0] sel, output reg y);

always@(*)begin
    case(sel)
        2'b00 : y = a;
        2'b01 : y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = a;
    endcase
end

endmodule


// Now Exercise 2 — priority_enc. This one uses if-else instead of case:
// Spec: Input in[3:0]. Output reg [1:0] pos. Find the index of the highest set bit.

// if in[3]=1 → pos=3
// else if in[2]=1 → pos=2
// else if in[1]=1 → pos=1
// else → pos=0

module priority_enc(input [3:0] in, output reg[1:0] pos);

always@(*) begin
    if(in[3] == 1) pos = 2'd3;
    else if(in[2] == 1) pos = 2'd2;
    else if(in[1] == 1) pos = 2'd1;
    else pos = 2'd0;
end
endmodule