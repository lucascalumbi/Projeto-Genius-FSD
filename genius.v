


module genius(
  input clock,
  input bt0,
  input bt1,
  input bt2,
  input sw[9:0],
  output segd0[6:0],
  output segd1[6:0],
  output segd2[6:0],
  output segd3[6:0],
  output leds[9:0]
);

  reg [6:0] showSequence = 3'h0;
  reg [6:0] receiveInputs = 3'h1;
  reg [6:0] addDifficult = 3'h2;
  reg [6:0] resetGame = 3'h3;

  reg [2:0] state, nextState;

  reg [1:0]zero = 2'b00;
  reg [1:0]one = 2'b01;
  reg [1:0]two = 2'b10;

  reg [1:0] mySequence [0:15];

  initial begin
    mySequence[0] = zero;
    mySequence[1] = zero;
    mySequence[2] = one;
    mySequence[3] = one;
    mySequence[4] = two;
    mySequence[5] = two;
    mySequence[6] = zero;
    mySequence[7] = zero;
    mySequence[8] = one;
    mySequence[9] = one;
    mySequence[10] = two;
    mySequence[11] = two;
    mySequence[12] = zero;
    mySequence[13] = zero;
    mySequence[14] = one;
    mySequence[15] = one;
  end

  always @(posedge clock)
  begin 
    if (sw[0])
      state <= resetGame;
    else
      state <= nextState;
  end

  always @(state)
  begin
    case (state)
      showSequence: 
      begin
        // mostre a sequencia atual
      end
      receiveInputs:  
      begin
        // receba as entradas do usuario
      end
      addDifficult: 
      begin 
        // aumente a sequencia
      end 
      resetGame:
      begin
        // resetar o jogo
      end 
    endcase
  end
  
endmodule

module showSequence(
  input reg [1:0] mySequence [0:15]
);


endmodule



   

module dec7seg(
    output reg [6:0]x, 
    input [3:0]a
);

  always @(*) 
  begin
    case (a)
      4'h0: begin x <= 7'b1111110; end
      4'h1: begin x <= 7'b0110000; end
      4'h2: begin x <= 7'b1101101; end
      4'h3: begin x <= 7'b1111001; end
      4'h4: begin x <= 7'b0110011; end
      4'h5: begin x <= 7'b1011011; end
      4'h6: begin x <= 7'b1011111; end
      4'h7: begin x <= 7'b1110000; end
      4'h8: begin x <= 7'b1111111; end
      4'h9: begin x <= 7'b1111011; end
      default: begin x <= 7'b0000000; end
    endcase
  end
endmodule     

module dec7seg1x2(
    output reg [6:0] x,  
    output reg [6:0] y,
    input [3:0] a
);

  wire [6:0] seg_x, seg_y;

  dec7seg d1(.x(seg_x), .a(a < 10 ? a : a - 10));
  dec7seg d2(.x(seg_y), .a(a < 10 ? 0 : a - 10));

  always @(*) begin
    x <= seg_x;
    y <= seg_y;
  end
endmodule 

