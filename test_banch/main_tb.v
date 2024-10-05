`timescale 1ns/1ns
`include "main.v"

module genius_tb; 
  // Declaração de sinais
  logic clock, start, reset;
  logic btn0, btn1, btn2;
  wire [6:0] segd0;    
  wire [6:0] segd1;    
  wire [6:0] segd2;    
  wire [6:0] segd3;
  wire [9:0] leds;
  logic [9:2] sw;

  // Geração de clock com período de 20 ns (50 MHz)
  always begin
     #10 clock = ~clock;
  end
    
  // Testbench
  initial begin
    // Dumpfile para visualização da simulação
    $dumpfile("genius_tb.vcd"); 
    $dumpvars(0, genius_tb);

    // Inicialização dos sinais
    clock = 0;
    reset = 0;
    start = 0;
    btn0 = 0;
    btn1 = 0;
    btn2 = 0;
    sw = 8'b00000000;

    // Sequência de testes

    // 1. Aplicar reset
    #10 reset = 1; 
    #10 reset = 0; 

    // 2. Iniciar o jogo
    #10 start = 1; 
    #20 start = 0; 

    // 3. Simular pressionamento dos botões
    #100 btn0 = 1; // Pressionar btn0
    #50 btn0 = 0;  // Soltar btn0

    #100 btn1 = 1; // Pressionar btn1
    #50 btn1 = 0;  // Soltar btn1

    #100 btn2 = 1; // Pressionar btn2
    #50 btn2 = 0;  // Soltar btn2

    // 4. Simulação finalizada
    #10000 $finish;   
  end

  // Instância do módulo genius
  genius genius0(
    .clock(clock),
    .btn({btn2, btn1, btn0}),
    .reset(reset),
    .start(start), 
    .sw(sw),
    .segd0(segd0),  
    .segd1(segd1),  
    .segd2(segd2),  
    .segd3(segd3), 
    .leds(leds)    
  );

endmodule
