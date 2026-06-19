`include "exercicio-3-14.v"

// ==========================================
// 2. O SIMULADOR (MÓDULO TESTBENCH)
// ==========================================
`timescale 1ns/1ns // Unidade de tempo / Precisão de tempo (5.001 funciona)

module deslocador_bidirecional_tb;
    // Definindo como reg para armazenar estados passados 
    reg clk = 0;
    reg rst = 0;
    reg serial_input;
    reg right = 1;
    wire [4:0] out;

    // Criando uma instância/cópia do circuito dentro do simulador
    deslocador_bidirecional uut (
        .clk(clk), 
        .rst(rst), 
        .serial_input(serial_input),
        .right(right),
        .Q(out)
    );

    // Faz o clock oscilar de 5 em 5 nanosegundos de forma infinita
    always #5 clk = ~clk;

    initial begin
        $dumpfile("resultado.vcd"); // Cria o arquivo de ondas (que salva a simulação inteira, até o $finish)
        $dumpvars(0, deslocador_bidirecional_tb);       // Salva as variáveis do teste

        $display("[Teste] Começou a simulação!");
        
        // Inicializa os sinais
        $display("[Teste] Dando Reset, esperando 10ns");
        rst = 1; // Liga o reset
        #10;     // Espera passar 10ns
        
        $display("[Teste] Desligando Reset, Emitindo 1 no Serial Input, com Right = 1 e esperando 10ns");
        rst = 0;
        serial_input = 1;
        right = 1;
        #10;
        $display("[Teste] Rodando por 40ns (4 pulsos de clock)");
        serial_input = 0;
        #40;
        $display("[Teste] Invertendo e rodando por 40ns (4 pulsos de clock)");
        right = 0;
        #40;
        
        $display("[Teste] Fim da simulação.");
        $finish; // IMPORTANTE: Para o relógio do simulador, senão ele roda eterno
    end
endmodule