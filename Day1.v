// #Exercise 1
// Write module swap_bytes. Input in[15:0]. Output out[15:0]. 
// Swap the two bytes — high byte of out = low byte of in, 
// low byte of out = high byte of in. One assign using concatenation.

module swap_bytes(input [15:0] in. output [15:0] out);

    assign out = {in[7:0], in[15:8]};

endmodule


// Write module sign_ext. Input in[7:0]. Output out[15:0].
// Sign-extend in to 16 bits — replicate bit 7 into the top 8 bits

module sign_ext(input [7:0]in, output [15:0] out);

    assign out = {{8{in[7]}},in};

endmodule