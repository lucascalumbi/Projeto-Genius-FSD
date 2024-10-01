module genius(
  input clock,
  input btn0,
  input btn1,
  input btn2,
  input [9:0] sw,
  output reg [6:0] segd0,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [2:0] state, nextState;
reg [3:0] count;
reg terminou;
reg acertou;


  // estados da FSM
  parameter resetGame = 3'o0;
  parameter showSequence = 3'o1;
  parameter receiveInputs = 3'o2;
  parameter addDifficult = 3'o3;
  

wire [1:0] number;
wire [6:0] segd_0; 
wire [6:0] segd_2;
wire [6:0] segd_3;
wire acertoutemp;

mySequence seq_inst(.count(count), .sw(sw[0]), .number(number));
dec7seg2bits dec2(.x(segd_0), .a(number));
dec7seg1x2 dec7(.x(segd_3), .y(segd_2), .a(count));
verificar_botao verificar(.btn0(btn0), .btn1(btn1), .btn2(btn2), .number(number), .acertou(acertoutemp));

always @(posedge clock) begin
    state <= nextState;

    if (state == addDifficult) 
        count <= count + 1'b1;

    case (state)
          resetGame: begin
        // Resetar o jogo
        segd0 <= segd_0;
        segd2 <= segd_2;      
        segd3 <= segd_3;
        if (sw[1]) begin 
            nextState <= 3'b001;
        end
    end
      showSequence: begin
        segd0 <= segd_0;
        segd2 <= segd_2;
        segd3 <= segd_3;
        terminou <= terminou + 1'b1;
        
            if (terminou) begin
                leds <= 10'b0000000001;
                nextState <= 3'b010;
            end
            terminou <= terminou + 1'b1;
      end
      receiveInputs: begin
        segd0 <= segd_0;
        segd2 <= segd_2;      
        segd3 <= segd_3;
		acertou <= acertoutemp;
            if (acertou) begin 
                leds <= 10'b0000000010;
                nextState <= 3'b011;
				acertou <= 1'b0;
            end
            else begin
                leds <= 10'b0000000100;
                nextState <= 3'b000;
            end
        end          

      addDifficult: begin
        // Aumente a sequência
        segd0 <= segd_0;
        segd2 <= segd_2;      
        segd3 <= segd_3;
        if (count < 16) begin 
            nextState <= 3'b001;
        end
        else begin
            nextState <= 3'b000;
        end
    end 

      default: begin
        leds <= 10'b0000000000; 
        segd0 <= 7'b0000000; 
        segd2 <= count;   
        segd3 <= count;     
        nextState <= 3'b000;     
      end 
    endcase
  end
endmodule


module dec7seg1x2(
    output [6:0] x,
    output [6:0] y,
    input [3:0] a
);

dec7seg dec7seg0(.a( (a > 4'h9) ? a - 4'ha : a), .x(y));
dec7seg dec7seg1(.x(x), .a((a > 4'h9) ? 4'h1 : 4'h0));

endmodule

module dec7seg(
    output [6:0] x, 
    input [3:0] a
);

  assign x = (a == 4'h0) ? 7'b1111110 :
             (a == 4'h1) ? 7'b0110000 :
             (a == 4'h2) ? 7'b1101101 :
             (a == 4'h3) ? 7'b1111001 :
             (a == 4'h4) ? 7'b0110011 :
             (a == 4'h5) ? 7'b1011011 :
             (a == 4'h6) ? 7'b1011111 :
             (a == 4'h7) ? 7'b1110000 :
             (a == 4'h8) ? 7'b1111111 :
             (a == 4'h9) ? 7'b1111011 :
             7'b0000000; 
             
endmodule   
 

module dec7seg2bits(
    output [6:0] x, 
    input [1:0] a
);

  assign x = (a == 2'b00) ? 7'b1111110 :
             (a == 2'b01) ? 7'b0110000 :
             (a == 2'b10) ? 7'b1101101 :
             (a == 2'b11) ? 7'b0000000 :
             7'b0000000; // default case

endmodule  


module mySequence (
    input [3:0] count,
    input sw,
    output reg [1:0] number
);

parameter [1:0] zero = 2'b00;
parameter [1:0] one = 2'b01;
parameter [1:0] two = 2'b10;

reg [1:0] mySequence_0;
reg [1:0] mySequence_1;
reg [1:0] mySequence_2;
reg [1:0] mySequence_3;
reg [1:0] mySequence_4;
reg [1:0] mySequence_5;
reg [1:0] mySequence_6;
reg [1:0] mySequence_7;
reg [1:0] mySequence_8;
reg [1:0] mySequence_9;
reg [1:0] mySequence_10;
reg [1:0] mySequence_11;
reg [1:0] mySequence_12;
reg [1:0] mySequence_13;
reg [1:0] mySequence_14;
reg [1:0] mySequence_15;

always @(posedge sw) begin 
    mySequence_0 <= two;
    mySequence_1 <= one;
    mySequence_2 <= zero;
    mySequence_3 <= one;
    mySequence_4 <= zero;
    mySequence_5 <= two;
    mySequence_6 <= zero;
    mySequence_7 <= two;
    mySequence_8 <= zero;
    mySequence_9 <= one;
    mySequence_10 <= zero;
    mySequence_11 <= two;
    mySequence_12 <= zero;
    mySequence_13 <= one;
    mySequence_14 <= zero;
    mySequence_15 <= one;
end

always @(count) begin
    case (count)
        4'd0: number <= mySequence_0;
        4'd1: number <= mySequence_1;
        4'd2: number <= mySequence_2;
        4'd3: number <= mySequence_3;
        4'd4: number <= mySequence_4;
        4'd5: number <= mySequence_5;
        4'd6: number <= mySequence_6;
        4'd7: number <= mySequence_7;
        4'd8: number <= mySequence_8;
        4'd9: number <= mySequence_9;
        4'd10: number <= mySequence_10;
        4'd11: number <= mySequence_11;
        4'd12: number <= mySequence_12;
        4'd13: number <= mySequence_13;
        4'd14: number <= mySequence_14;
        4'd15: number <= mySequence_15;
        default: number <= 2'b00; 
    endcase
end

endmodule

module verificar_botao(
    input btn0,
    input btn1,
    input btn2,
    input [1:0] number,
    output acertou
);

    assign acertou = (btn0 && (number == 2'b00)) || 
                     (btn1 && (number == 2'b01)) || 
                     (btn2 && (number == 2'b10));

endmodule
