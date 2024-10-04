
module dec7seg_2bits(
    output [6:0] x, 
    input [1:0] a
);

  assign x = (a == 2'b00) ? 7'b1111110 :
             (a == 2'b01) ? 7'b0110000 :
             (a == 2'b10) ? 7'b1101101 :
             (a == 2'b11) ? 7'b0000000 :
             7'b0000000; 

endmodule