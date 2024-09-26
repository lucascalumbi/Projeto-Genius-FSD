
module genius(
  input clock,
  input bt0,
  input bt1,
  input bt2,
  input [9:0] sw,
  output reg [6:0] segd0,  
  output reg [6:0] segd1,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [2:0] state, nextState;
reg [1:0] mySequence [0:15]; 
reg [3:0] count;

parameter [1:0] zero = 2'b00;
parameter [1:0] one = 2'b01;
parameter [1:0] two = 2'b10;



    always @(posedge sw[0]) begin 
        state <= 3'b000;
        nextState <= 3'b000;
        count <= 3'b000;

        mySequence[0] <= zero;
        mySequence[1] <= one;
        mySequence[2] <= zero;
        mySequence[3] <= one;
        mySequence[4] <= zero;
        mySequence[5] <= two;
        mySequence[6] <= zero;
        mySequence[7] <= two;
        mySequence[8] <= zero;
        mySequence[9] <= one;
        mySequence[10] <= zero;
        mySequence[11] <= two;
        mySequence[12] <= zero;
        mySequence[13] <= one;
        mySequence[14] <= zero;
        mySequence[15] <= one;
    end


  // estados da FSM
  parameter showSequence = 3'o0;
  parameter receiveInputs = 3'o1;
  parameter addDifficult = 3'o2;
  parameter resetGame = 3'o3;
  
  // Contador
  always @(posedge clock) begin
    if(sw[0]) begin
    count <= 4'h0;
    end
    else begin
    count <= count + 1'b1;
    end
  end 

  // Transição de estado
  always @(posedge clock ) begin 
      state <= nextState;
  end

  always @(negedge clock) begin 
      state <= nextState;
  end


  always @(state) begin
    case (state)
      showSequence: begin
        leds <= 10'b1111111111;
        segd0 <= 7'b0000000;
        segd1 <= 7'b0000000;
        segd2 <= 7'b0000000;
        segd3 <= 7'b0000000;
        nextState <= 3'b000;
      end
      receiveInputs: begin
        // Receba as entradas do usuário
        leds <= 10'b0000000000;  
      segd0 <= 7'b0000000;      
      segd1 <= 7'b0000000;      
      segd2 <= 7'b0000000;      
      segd3 <= 7'b0000000;     
        nextState <= 3'b000;
      end
      addDifficult: begin
        // Aumente a sequência
        leds <= 10'b0000000000;  
      segd0 <= 7'b0000000;      
      segd1 <= 7'b0000000;      
      segd2 <= 7'b0000000;      
      segd3 <= 7'b0000000;      
              nextState <= 3'b000;

      end 
      resetGame: begin
        // Resetar o jogo
        leds <= 10'b0000000000;  
      segd0 <= 7'b0000000;      
      segd1 <= 7'b0000000;      
      segd2 <= 7'b0000000;      
      segd3 <= 7'b0000000;      
              nextState <= 3'b000;

      end
      default: begin
      leds <= 10'b0000000000;  
      segd0 <= 7'b0000000;      
      segd1 <= 7'b0000000;     
      segd2 <= 7'b0000000;      
      segd3 <= 7'b0000000;     
              nextState <= 3'b000;
      
      end 
    endcase
  end
  
endmodule

/*
module dec7seg1x2(
    output reg [6:0] x,
    output reg [6:0] y,
    input [3:0] a
);

dec7seg dec7seg0(.a( (a > 4'h9) ? a - 4'ha : a), .x(y));
dec7seg dec7seg1(.x(x), .a((a > 4'h9) ? 4'h1 : 4'h0));

endmodule

module dec7seg(
    output reg [6:0] x, 
    input [3:0] a
);

  always @(*) begin
    case (a)
      4'h0: x = 7'b1111110;
      4'h1: x = 7'b0110000;
      4'h2: x = 7'b1101101;
      4'h3: x = 7'b1111001;
      4'h4: x = 7'b0110011;
      4'h5: x = 7'b1011011;
      4'h6: x = 7'b1011111;
      4'h7: x = 7'b1110000;
      4'h8: x = 7'b1111111;
      4'h9: x = 7'b1111011;
      default: x = 7'b0000000;
    endcase
  end
endmodule   
*/  
