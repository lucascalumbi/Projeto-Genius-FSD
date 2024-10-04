
module genius(
  input clock,
  input [2:0] btn,
  input reset,
  input start, // Ativa em baixo
  input [9:2] sw,
  output reg [6:0] segd0,  
  output reg [6:0] segd1,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [3:0] sequence_count;
reg [1:0] current_number;
my_sequence seq(.current_number(current_number), .sequence_count(sequence_count), .start(!start));

wire [6:0] segd_0; 
dec7seg_2bits dec7_2bits(.x(segd_0), .a(current_number));

reg [3:0] current_level;
wire [6:0] segd_2;
wire [6:0] segd_3;
dec7seg_4bits_1x2 dec7_4bits_1x2(.x(segd_3), .y(segd_2), .a(current_level));

wire is_right_choice;
verify_btn verifier(.is_right_choice(is_right_choice), .btn(btn), .current_number(current_number));

wire was_some_btn_pressed;
recieve_btn_input btn_input(.was_some_btn_pressed(was_some_btn_pressed), .btn(btn));

wire shifted_leds;
shift_leds shift(.y(shifted_leds), .x(leds));

reg [2:0] state, next_state;
  // estados da FSM
  parameter reset_game_state = 3'o0;
  parameter show_sequence_state = 3'o1;
  parameter receive_inputs_state = 3'o2;
  parameter add_difficult_state = 3'o3;

always @(posedge clock) begin
    state <= next_state;
    segd1 <= 10'b0000000000;
    segd2 <= segd_2;      
    segd3 <= segd_3;

    case (state)
      reset_game_state: begin
        leds <= 10'b1111111111;
        segd0 <= 10'b0000000000;
        // Resetar o jogo
        if (start) begin 
          sequence_count <= 4'h0;
          current_level <= 4'h0;
          leds <= 10'b0000000001;
          next_state <= show_sequence_state;
        end
      end

      show_sequence_state: begin
        segd0 <= segd_0;
        if (sequence_count > current_level) begin
          leds <= 10'b0000000001;
          sequence_count <= 4'h0;
          next_state <= receive_inputs_state;
        end
        else begin
          sequence_count <= sequence_count + 1'b1;
          leds <= shifted_leds;
        end 
      end
      
      receive_inputs_state: begin
        segd0 <= 10'b0000000000;
        if (sequence_count > current_level) begin 
            next_state <= add_difficult_state;
        end
        if(was_some_btn_pressed) begin
          if(is_right_choice) begin
            //leds <= 10'b1111111111;
            leds <= shifted_leds;
            sequence_count <= sequence_count + 1'b1;
            next_state <= receive_inputs_state;
          end 
          else begin
            leds <= 10'b0000000000;
            next_state <= reset_game_state;
          end
        end   
        

      end       

      add_difficult_state: begin
        // Aumente a sequência
        segd0 <= 10'b0000000000;
        if (current_level < 15) begin 
            current_level <= current_level + 1'b1;
            sequence_count <= 1'h0;
            next_state <= show_sequence_state;
        end
        else begin
            next_state <= reset_game_state;
        end
      end 

      default: begin
        leds <= 10'b0000000000;
        next_state <= reset_game_state;     
      end 
    endcase
  end
endmodule



module my_sequence (
    output reg [1:0] current_number,
    input [3:0] sequence_count,
    input start
);

parameter [1:0] zero = 2'b00;
parameter [1:0] one = 2'b01;
parameter [1:0] two = 2'b10;

reg [1:0] sequence_0;
reg [1:0] sequence_1;
reg [1:0] sequence_2;
reg [1:0] sequence_3;
reg [1:0] sequence_4;
reg [1:0] sequence_5;
reg [1:0] sequence_6;
reg [1:0] sequence_7;
reg [1:0] sequence_8;
reg [1:0] sequence_9;
reg [1:0] sequence_10;
reg [1:0] sequence_11;
reg [1:0] sequence_12;
reg [1:0] sequence_13;
reg [1:0] sequence_14;
reg [1:0] sequence_15;

always @(posedge start) begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= one;
    sequence_4 <= zero;
    sequence_5 <= two;
    sequence_6 <= zero;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= one;
    sequence_10 <= zero;
    sequence_11 <= two;
    sequence_12 <= zero;
    sequence_13 <= one;
    sequence_14 <= zero;
    sequence_15 <= one;
end

always @(*) begin
    case (sequence_count)
        4'h0: current_number <= sequence_0;
        4'h1: current_number <= sequence_1;
        4'h2: current_number <= sequence_2;
        4'h3: current_number <= sequence_3;
        4'h4: current_number <= sequence_4;
        4'h5: current_number <= sequence_5;
        4'h6: current_number <= sequence_6;
        4'h7: current_number <= sequence_7;
        4'h8: current_number <= sequence_8;
        4'h9: current_number <= sequence_9;
        4'hA: current_number <= sequence_10;
        4'hB: current_number <= sequence_11;
        4'hC: current_number <= sequence_12;
        4'hD: current_number <= sequence_13;
        4'hE: current_number <= sequence_14;
        4'hF: current_number <= sequence_15;
        default: current_number <= 2'b00; 
    endcase
end

endmodule

module dec7seg_4bits_1x2(
    output [6:0] x,
    output [6:0] y,
    input [3:0] a
); 

dec7seg_4bits d0(.x(y), .a( (a > 4'h9) ? a - 4'ha : a));
dec7seg_4bits d1(.x(x), .a((a > 4'h9) ? 4'h1 : 4'h0));

endmodule

module dec7seg_4bits(
  output [6:0] x, 
  input [3:0] a
);

  assign x =  (a == 4'h0) ? 7'b1111110 :
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

module verify_btn(
    output is_right_choice,
    input [2:0] btn,
    input [1:0] current_number
);

    assign is_right_choice =    (btn[0] && (current_number == 2'b00)) || 
                                (btn[1] && (current_number == 2'b01)) || 
                                (btn[2] && (current_number == 2'b10));

endmodule

module recieve_btn_input(
    output was_some_btn_pressed,
    input [2:0] btn
);

    assign was_some_btn_pressed = btn[0] || btn[1] || btn[2];

endmodule


module shift_leds(
    output [9:0] y,
    input [9:0] x
);

    assign y = x[9] ? 10'b0000000001 : x << 1'b1; 

endmodule
