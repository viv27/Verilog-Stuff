module clock_gate(
    input clk,
    input enable,
    output gated_clk
)

reg latch_enable;
always @(clk,enable) begin
    if(!clk) latch_enable <= enable; // latch enable when clk is low
end

assign gated_clk = clk & latch_enable;