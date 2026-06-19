`include "exercicio-3-12.v"

// ==========================================
// 2. O SIMULADOR (MÓDULO TESTBENCH)
// ==========================================
`timescale 1ns/1ns // Unidade de tempo / Precisão de tempo (5.001 funciona)

module contador_johson_tb;
    // Definindo como reg para armazenar estados passados 
    reg clk = 0;
    reg rst;
    // Definindo como wire pois são controladas pelo flip-flop, não pelo testbench
    wire [4:0] cont;

    // Criando uma instância/cópia do circuito dentro do simulador
    contador_johson uut (
        .clk(clk), 
        .rst(rst), 
        .cont(cont)
    );

    // Faz o clock oscilar de 5 em 5 nanosegundos de forma infinita
    always #5 clk = ~clk;

    initial begin
        $dumpfile("resultado.vcd"); // Cria o arquivo de ondas (que salva a simulação inteira, até o $finish)
        $dumpvars(0, contador_johson_tb);       // Salva as variáveis do teste

        $display("[Teste] Começou a simulação!");
        
        // Inicializa os sinais
        $display("[Teste] Dando Reset, esperando 10ns");
        rst = 1; // Liga o reset
        #10;     // Espera passar 12ns
        
        $display("[Teste] Desligando Reset e rodando por 100ns (10 pulsos de clock)");
        rst = 0; // Desliga o reset
        #100;     // Espera passar 10ns (vai pegar uma borda de descida aqui)
        
        $display("[Teste] Fim da simulação.");
        $finish; // IMPORTANTE: Para o relógio do simulador, senão ele roda eterno
    end
endmodule