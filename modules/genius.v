module genius(
  input clock,
  input [2:0] btn,
  input reset,
  input start, 
  input [5:2] sw,
  output reg [6:0] segd0,  
  output reg [6:0] segd1,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [3:0] sequence_count;
wire [1:0] current_number;
my_sequence seq(.current_number(current_number), .sequence_count(sequence_count), .clk(clock), .start(start), .sw(sw[5:2]));

wire [6:0] segd_0; 
//dec7seg_4bits_hexadec dec7seg_4bits_hexadec0(.y(segd_0), .a({2'b00,current_number}));
dec7seg_2bits dec7_2bits(.x(segd_0), .a(current_number));
reg [3:0] current_level;
wire [6:0] segd_2;
wire [6:0] segd_3;
//dec7seg_4bits_hexadec dec7seg_4bits_hexadec1(.y(segd_3), .a(current_level)); // temporario
//dec7seg_4bits_hexadec dec7seg_4bits_hexadec2(.y(segd_2), .a(sequence_count)); // temporario
dec7seg_4bits_1x2 dec7_4bits_1x2(.x(segd_3), .y(segd_2), .a(current_level));

wire is_right_choice;
verify_btn verifier(.is_right_choice(is_right_choice), .btn(btn), .current_number(current_number));

wire was_some_btn_pressed;
recieve_btn_input btn_input(.was_some_btn_pressed(was_some_btn_pressed), .btn(btn));

wire [9:0] shifted_leds;
shift_leds shift(.y(shifted_leds), .x(leds));

reg [2:0] state, next_state;
reg clock_count;
reg [3:0] seq_count;

// estados da FSM
parameter reset_game_state = 3'o0;
parameter show_sequence_state = 3'o1;
parameter receive_inputs_state = 3'o2;
parameter add_difficult_state = 3'o3;

parameter seg_off = 7'b0000000;
parameter leds_off = 10'b0000000000; 
parameter leds_on = 10'b1111111111;


always @(posedge clock) begin
  if(!reset) begin
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
          if (start && sw) begin 
            sequence_count <= 4'h0;
            current_level <= 4'h0;
            leds <= 10'h1;
            next_state <= show_sequence_state; // mostre a sequencia de numeros
          end
        end

        show_sequence_state: begin
            segd0 <= segd_0;
            clock_count <= 1'b0;
            if (next_state == receive_inputs_state) begin
                leds <= 10'b0000000001;
            end
          else if (seq_count >= current_level) begin
            sequence_count <= 4'h0;
            next_state <= receive_inputs_state;
          end
          else begin
            sequence_count <= sequence_count + 1'b1;
            seq_count <= seq_count + 1'b1;
            //leds <= shifted_leds;
            next_state <= state; // mantenha o estado atual
          end 
        end
        
        receive_inputs_state: begin
          segd0 <= seg_off;
          seq_count <= 1'b0;
          if (sequence_count > current_level) begin
              leds <= leds_off;
              next_state <= add_difficult_state;
          end
          else begin 
            if(was_some_btn_pressed) begin
              if(is_right_choice) begin
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
          if (current_level < 15 && clock_count == 0) begin 
              clock_count <= clock_count + 1'b1;
              current_level <= current_level + 1'b1;
              next_state <= state; // mantem no mesmo estado
          end
          else if (current_level < 15 && clock_count == 1) begin 
              sequence_count <= 4'h0;
              next_state <= show_sequence_state;
          end
          else begin
            leds <= 10'b1111111111;
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
      segd1 <= seg_off;
      leds <= leds_off;
      segd2 <= seg_off;      
      segd3 <= seg_off;
    end
//begin2
  end
endmodule