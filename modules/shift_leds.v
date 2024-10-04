
module shift_leds(
    output [9:0] y,
    input [9:0] x
);

    assign y = x[9] ? 10'b0000000001 : x << 1'b1; 

endmodule