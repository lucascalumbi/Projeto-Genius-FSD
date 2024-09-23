

module genius(
  input clock,
  input bt0,
  input bt1,
  input bt2,
  input sw[0:9],
  output segd0[0:6],
  output segd1[0:6],
  output segd2[0:6],
  output segd3[0:6],
  output leds[0:9]
);



  parameter
        showSequence = 3'h0;
        receiveInputs = 3'h1;
        addDifficult = 3'h2;
        resetGame = 3'h3;

  reg [0:2] state, nextState;

  reg [1:0] sequence [15:0];

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






module dec7seg1x2(
    input [3:0]a, 
    output reg [6:0]x,  
    output reg [6:0]y 
);

  parameter
    nulo = 7'b0000000;
    zero = 7'b1111110;
    one = 7'b0110000;
    two = 7'b1101101;
    three = 7'b1111001;
    four = 7'b0110011;
    five = 7'b1011011;
    six = 7'b1011111;
    seven = 7'b1110000;
    eight = 7'b1111111;
    nine = 7'b1111011;

  always @(*) 
  begin
    case (a)
      4'h0: 
        begin
          x <= zero;
          y <= zero;
        end
      4'h1: 
        begin
          x <= zero;
          y <= one;
        end
      4'h2: 
        begin
          x <= zero;
          y <= two;
        end
      4'h3: 
        begin
          x <= zero;
          y <= three;
        end
      4'h4: 
        begin
          x <= zero;
          y <= four;
        end
      4'h5: 
        begin
          x <= zero;
          y <= five;
        end
      4'h6: 
        begin
          x <= zero;
          y <= six;
        end
      4'h7: 
        begin
          x <= zero;
          y <= seven;
        end
      4'h8: 
        begin
          x <= zero;
          y <= eight;
        end
      4'h9:
        begin
          x <= zero;
          y <= nine;
        end
      4'hA: 
        begin
          x <= one;
          y <= zero;
        end
      4'hB:
        begin
          x <= one;
          y <= one;
        end
      4'hC:
        begin
          x <= one;
          y <= two;
        end
      4'hD:
        begin
          x <= one;
          y <= three;
        end
      4'hE:
        begin
          x <= one;
          y <= four;
        end
      4'hF:
        begin
          x <= zero;
          y <= five;
        end
      default: 
        begin 
          x <= nulo; 
          y <= nulo; 
        end
    endcase
  end
endmodule     



