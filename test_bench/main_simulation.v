module genius(
  input clock,
  input [2:0] btn,
  input reset,
  input start, 
  input [5:2] sequences_opitions,
  output reg [6:0] segd0,  
  output reg [6:0] segd1,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [3:0] sequence_count;
wire [1:0] current_sequence_number;
my_sequence seq(
  .current_sequence_number(current_sequence_number), 
  .sequence_count(sequence_count), 
  .clock(clock), 
  .start(start), 
  .sequences_opitions(sequences_opitions)
);

wire [6:0] segd_0; 
dec7seg_2bits dec7_2bits(
  .out(segd_0), 
  .in(current_sequence_number)
);

reg [4:0] current_level;
wire [6:0] segd_2;
wire [6:0] segd_3;
dec7seg_4bits_1x2 dec7_4bits_1x2(.x(segd_3), .y(segd_2), .a(current_level));

wire was_right_btn_pressed;
wire was_some_btn_pressed;
recieve_btn_input btn_input(
  .was_right_btn_pressed(was_right_btn_pressed),
  .was_some_btn_pressed(was_some_btn_pressed), 
  .btn(btn), 
  .current_sequence_number(current_sequence_number)
);

wire [9:0] shifted_leds;
shift_leds shift(
  .y(shifted_leds), 
  .x(leds)
);

reg [1:0] state, next_state;
reg clock_count;
reg [3:0] seq_count;

// estados da FSM
parameter reset_game_state = 2'h0;
parameter show_sequence_state = 2'h1;
parameter receive_inputs_state = 2'h2;
parameter add_difficult_state = 2'h3;

parameter seg_off = 7'b0000000;
parameter seg_on = 7'b1111111;
parameter leds_off = 10'b0000000000; 
parameter leds_on = 10'b1111111111;


always @(posedge clock) begin
  if(!reset && sequences_opitions && start) begin
      state <= next_state;
      segd1 <= seg_off;
      segd2 <= segd_2;      
      segd3 <= segd_3;

      case (state)
        reset_game_state: begin
          leds <= leds_on;
          segd0 <= seg_off;
          next_state <= state; // mantenha o estado atual
          // Resetar o jogo
          if (start && sequences_opitions) begin 
            sequence_count <= 5'h0;
            current_level <= 4'h0;
            leds <= 10'h1;
            next_state <= show_sequence_state; // mostre a sequencia de numeros
          end
        end

        show_sequence_state: begin
            segd0 <= segd_0;
            clock_count <= 1'b0;
          if (seq_count == current_level) begin
            sequence_count <= 5'h0;
            next_state <= receive_inputs_state;
          end
          else begin
            sequence_count <= sequence_count + 1'b1;
            seq_count <= seq_count + 1'b1;
            next_state <= state; // mantenha o estado atual
          end 
        end
        
        receive_inputs_state: begin
          segd0 <= seg_off;
          if(seq_count == current_level) begin 
            seq_count <= 1'b0;
            leds <= 10'h1;
          end 
          if (sequence_count > current_level) begin
              leds <= leds_off;
              next_state <= add_difficult_state;
          end
          else begin 
            if(was_some_btn_pressed) begin
              if(was_right_btn_pressed) begin
                leds <= shifted_leds;
                sequence_count <= sequence_count + 1'b1;
                next_state <= state; // mantenha o estado atual
              end 
              else begin
                leds <= leds_off;
                next_state <= reset_game_state; // jogador perdeu, resete o jogo
              end
            end
            else begin
              next_state <= state; // mantenha o estado atual
            end 
          end
        end       

        add_difficult_state: begin
          // Aumente a sequência
          segd0 <= seg_off;
          if (current_level < 16 && clock_count == 0) begin 
              clock_count <= clock_count + 1'b1;
              current_level <= current_level + 1'b1;
              next_state <= state; // mantem no mesmo estado
          end
          else if (current_level < 16 && clock_count == 1) begin 
              sequence_count <= 5'h0;
              next_state <= show_sequence_state;
          end
          else begin
            leds <= leds_on;
            segd0 <= seg_on;
            segd1 <= seg_on;
            segd2 <= seg_on;
            segd3 <= seg_on;
            current_level <= 4'h0;
            next_state <= reset_game_state; // jogador ganhou, resete o jogo
          end
        end 

        default: begin
          leds <= leds_off;
          next_state <= reset_game_state;     
        end 
      endcase
    end
    else begin
      leds <= leds_off;
      segd0 <= seg_off;
      segd1 <= seg_off;
      segd2 <= seg_off;      
      segd3 <= seg_off;
      seq_count <= 4'h0;
      sequence_count <= 4'h0;
      current_level <= 5'h0;
      state <= reset_game_state;
      next_state <= reset_game_state;
    end
//begin2
State <= state;
Next_state <= next_state;
Current_level <= current_level;
Sequence_count <= sequence_count;
Current_number <= current_number;
//end
  end
endmodule
module my_sequence (
    output reg [1:0] current_sequence_number,
    input [3:0] sequence_count,
    input clock,
    input start,
    input [3:0] sequences_opitions
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
    if (sequences_opitions[0]) begin
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
    else if (sequences_opitions[1]) begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= two;
    sequence_4 <= one;
    sequence_5 <= zero;
    sequence_6 <= two;
    sequence_7 <= one;
    sequence_8 <= one;
    sequence_9 <= zero;
    sequence_10 <= two;
    sequence_11 <= zero;
    sequence_12 <= one;
    sequence_13 <= two;
    sequence_14 <= zero;
    sequence_15 <= one;
    end
    else if (sequences_opitions[2]) begin 
    sequence_0 <= zero;
    sequence_1 <= two;
    sequence_2 <= one;
    sequence_3 <= zero;
    sequence_4 <= two;
    sequence_5 <= one;
    sequence_6 <= one;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= one;
    sequence_10 <= zero;
    sequence_11 <= two;
    sequence_12 <= one;
    sequence_13 <= zero;
    sequence_14 <= two;
    sequence_15 <= one;
    end
    else begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= two;
    sequence_4 <= zero;
    sequence_5 <= one;
    sequence_6 <= one;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= two;
    sequence_10 <= one;
    sequence_11 <= zero;
    sequence_12 <= zero;
    sequence_13 <= two;
    sequence_14 <= one;
    sequence_15 <= two;
    end
/*    else if (sequences_opitions[4]) begin
    sequence_0 <= one;
    sequence_1 <= two;
    sequence_2 <= zero;
    sequence_3 <= one;
    sequence_4 <= two;
    sequence_5 <= zero;
    sequence_6 <= one;
    sequence_7 <= zero;
    sequence_8 <= two;
    sequence_9 <= one;
    sequence_10 <= two;
    sequence_11 <= zero;
    sequence_12 <= one;
    sequence_13 <= two;
    sequence_14 <= zero;
    sequence_15 <= one;
    end
    else begin
    sequence_0 <= two;
    sequence_1 <= zero;
    sequence_2 <= one;
    sequence_3 <= two;
    sequence_4 <= one;
    sequence_5 <= zero;
    sequence_6 <= zero;
    sequence_7 <= one;
    sequence_8 <= two;
    sequence_9 <= zero;
    sequence_10 <= one;
    sequence_11 <= two;
    sequence_12 <= zero;
    sequence_13 <= one;
    sequence_14 <= two;
    sequence_15 <= zero;
    end*/
end

always @(posedge clock) begin
    case (sequence_count)
        4'h0: current_sequence_number <= sequence_0;
        4'h1: current_sequence_number <= sequence_1;
        4'h2: current_sequence_number <= sequence_2;
        4'h3: current_sequence_number <= sequence_3;
        4'h4: current_sequence_number <= sequence_4;
        4'h5: current_sequence_number <= sequence_5;
        4'h6: current_sequence_number <= sequence_6;
        4'h7: current_sequence_number <= sequence_7;
        4'h8: current_sequence_number <= sequence_8;
        4'h9: current_sequence_number <= sequence_9;
        4'hA: current_sequence_number <= sequence_10;
        4'hB: current_sequence_number <= sequence_11;
        4'hC: current_sequence_number <= sequence_12;
        4'hD: current_sequence_number <= sequence_13;
        4'hE: current_sequence_number <= sequence_14;
        4'hF: current_sequence_number <= sequence_15;
        default: current_sequence_number <= 2'b00; 
    endcase
end

endmodule

module verify_btn(
    output is_right_choice,
    input [2:0] btn,
    input [1:0] current_sequence_number
);

    assign is_right_choice =    (btn[0] && (current_sequence_number == 2'b00)) || 
                                (btn[1] && (current_sequence_number == 2'b01)) || 
                                (btn[2] && (current_sequence_number == 2'b10));

endmodule

module recieve_btn_input(
    output was_some_btn_pressed,
    output was_right_btn_pressed,
    input [2:0] btn,
    input [1:0] current_sequence_number
);

verify_btn verify0(
    .is_right_choice(was_right_btn_pressed),
    .btn(btn),
    .current_sequence_number(current_sequence_number)
);
    assign was_some_btn_pressed = btn[0] + btn[1] + btn[2];


endmodule


module shift_leds(
    output [9:0] y,
    input [9:0] x
);

    assign y = x[9] ? 10'b0000000001 : x << 1'b1; 

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
    output [6:0] out, 
    input [1:0] in
);

  assign out = (in == 2'b00) ? 7'b1111110 :
             (in == 2'b01) ? 7'b0110000 :
             (in == 2'b10) ? 7'b1101101 :
             (in == 2'b11) ? 7'b0000000 :
             7'b0000000; 

endmodule
