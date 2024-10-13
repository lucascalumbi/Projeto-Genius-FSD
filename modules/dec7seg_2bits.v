module dec7seg_2bits(
    output [6:0] out, 
    input [1:0] in
);

  assign out = (in == 2'b00) ? 7'b1111110 :
             (in == 2'b01) ? 7'b0110000 :
             (in == 2'b10) ? 7'b1101101 :
             (in == 2'b11) ? 7'b0000000 :
             7'b0000000; 

endmodule