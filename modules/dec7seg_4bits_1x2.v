
module dec7seg_4bits_1x2(
    output [6:0] x,
    output [6:0] y,
    input [3:0] a
); 

dec7seg_4bits d0(.x(y), .a( (a > 4'h9) ? a - 4'ha : a));
dec7seg_4bits d1(.x(x), .a((a > 4'h9) ? 4'h1 : 4'h0));

endmodule