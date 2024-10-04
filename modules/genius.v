
module genius(
  input clock,
  input [2:0] btn,
  input reset,
  input start, 
  input [9:2] sw,
  output reg [6:0] segd0,  
  output reg [6:0] segd1,  
  output reg [6:0] segd2,  
  output reg [6:0] segd3, 
  output reg [9:0] leds    
);

reg [3:0] current_level;
reg [1:0] current_number;
reg [3:0] sequence_count;
reg [1:0] timer_count;


reg [2:0] state, next_state;
  // estados da FSM
  parameter reset_game = 3'o0;
  parameter show_sequence = 3'o1;
  parameter receive_inputs = 3'o2;
  parameter add_difficult = 3'o3;
  
wire [6:0] segd_0; 
//wire [6:0] segd_1; 
wire [6:0] segd_2;
wire [6:0] segd_3;
wire is_right_choice;

my_sequence seq(.current_number(current_number), .sequence_count(sequence_count), .start(start));
dec7seg_2bits dec7_2bits(.x(segd_0), .a(current_number));
dec7seg_4bits_1x2 dec7_4bits_1x2(.x(segd_3), .y(segd_2), .a(current_level));
verify_btn verifier(.is_right_choice(is_right_choice), .btn(btn), .current_number(current_number));

always @(posedge clock) begin
    state <= next_state;
    segd0 <= segd_0;
    segd1 <= 10'b0000000000;
    segd2 <= segd_2;      
    segd3 <= segd_3;

    case (state)
      reset_game: begin
        leds <= 10'b1111111111;
        // Resetar o jogo
        if (start) begin 
          sequence_count <= 4'h0;
          current_level <= 4'h0;
          next_state <= 3'o1;
        end
      end

      show_sequence: begin
        if (sequence_count == current_level) begin
          leds <= 10'b0000000001;
          timer_count <= 2'b00;
          next_state <= 3'o2;
        end
        else begin
          sequence_count <= sequence_count + 1'b1;
        end 
      end
      
      receive_inputs: begin
        leds <= 10'b0000000000;
        
        if(timer_count > 2) begin 
          timer_count <= 2'b00;
          if(is_right_choice) begin
            leds <= 10'b0000000010;
          end 
          else begin
            leds <= 10'b0000000100;
            next_state <= 3'o0;
          end 
        end
        else begin
          timer_count <= timer_count + 1'b1;
        end
        

        /*
        if (acertoutemp && tempo > 2) begin 
          leds <= 10'b0000000010;
          next_state <= 3'o3;
        end
        else if (!acertoutemp && tempo > 2) begin
          leds <= 10'b0000000100;
          next_state <= 3'o0;
        end
        */         
      end 

      add_difficult: begin
        // Aumente a sequência

        if (current_level < 15) begin 
            current_level <= current_level + 1'b1;
            next_state <= 3'o1;
        end
        else begin
            next_state <= 3'o0;
        end
      end 

      default: begin
        leds <= 10'b0000000000;
        next_state <= 3'b000;     
      end 
    endcase
  end
endmodule


