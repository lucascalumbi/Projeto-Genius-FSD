  module genius(
    input clock,
    input bt0,
    input bt1,
    input bt2,
    input [9:0] sw,
    output reg [6:0] segd0,  // Corrigido: agora é reg para armazenar o valor de saída
    output reg [6:0] segd1,  // Corrigido
    output reg [6:0] segd2,  // Corrigido
    output reg [6:0] segd3,  // Corrigido
    output reg [9:0] leds    // Corrigido: mesmo tipo para os LEDs
  );

    // Definição de estados da FSM
    parameter showSequence = 2'h0;
    parameter receiveInputs = 2'h1;
    parameter addDifficult = 2'h2;
    parameter resetGame = 2'h3;

    reg [1:0] state, nextState;

    // Definição das sequências
    reg [1:0] zero = 2'b00;
    reg [1:0] one = 2'b01;
    reg [1:0] two = 2'b10;

    reg [1:0] mySequence [0:15]; // Sequência armazenada

    reg [3:0] count;
    wire [6:0] seg_out;  // Saída para o display de 7 segmentos

    // Instanciação do módulo dec7seg
    dec7seg dec_inst(.x(seg_out), .a({2'b00, mySequence[count]}));

    // Contador
    always @(posedge clock or posedge sw[0]) begin
      if(sw[0]) begin
        count <= 4'h0;
      end 
      else begin
        count <= count + 1'b1;
      end
    end 

    // Inicialização da sequência
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

    // Transição de estado
    always @(posedge clock) begin 
      if (sw[0])
        state <= resetGame;
      else
        state <= nextState;
    end

    // Definição da FSM
    always @(state) begin
      case (state)
        showSequence: begin
          leds <= 10'b1111111111;
          segd0 <= seg_out;
          segd1 <= 7'b0000000;
          segd2 <= 7'b0000000;
          segd3 <= 7'b0000000;
          nextState <= 2'b00;
        end
        receiveInputs: begin
          // Receba as entradas do usuário
          leds <= 10'b0000000000;  // Valor padrão
        segd0 <= 7'b0000000;      // Valor padrão
        segd1 <= 7'b0000000;      // Valor padrão
        segd2 <= 7'b0000000;      // Valor padrão
        segd3 <= 7'b0000000;      // Valor padrão
        nextState <= 2'b00;
        end
        addDifficult: begin
          // Aumente a sequência
          leds <= 10'b0000000000;  // Valor padrão
        segd0 <= 7'b0000000;      // Valor padrão
        segd1 <= 7'b0000000;      // Valor padrão
        segd2 <= 7'b0000000;      // Valor padrão
        segd3 <= 7'b0000000;      // Valor padrão
        nextState <= 2'b00;
        end 
        resetGame: begin
          // Resetar o jogo
          leds <= 10'b0000000000;  // Valor padrão
        segd0 <= 7'b0000000;      // Valor padrão
        segd1 <= 7'b0000000;      // Valor padrão
        segd2 <= 7'b0000000;      // Valor padrão
        segd3 <= 7'b0000000;      // Valor padrão
        nextState <= 2'b00;
        end
        default: begin
        leds <= 10'b0000000000;  // Valor padrão
        segd0 <= 7'b0000000;      // Valor padrão
        segd1 <= 7'b0000000;      // Valor padrão
        segd2 <= 7'b0000000;      // Valor padrão
        segd3 <= 7'b0000000;      // Valor padrão
        nextState <= 2'b00;       // Valor padrão
        end 
      endcase
    end
    
  endmodule

  // Módulo dec7seg para display de 7 segmentos
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
