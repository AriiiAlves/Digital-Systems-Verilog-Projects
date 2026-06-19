`include "ffd.v"

// ==========================================
// 2. O SIMULADOR (MÓDULO TESTBENCH)
// ==========================================
`timescale 1ns/1ns // Unidade de tempo / Precisão de tempo (5.001 funciona)

module ffd_tb;
    // Definindo como reg para armazenar estados passados 
    reg D;
    reg clk = 0;
    reg rst;
    // Definindo como wire pois são controladas pelo flip-flop, não pelo testbench
    wire Q;
    wire Qb;

    // Criando uma instância/cópia do circuito dentro do simulador
    ffd uut (
        .D(D), // "Pegue a porta de entrada .D do chip e solde nela o fio/registrador D do testbench"
        .clk(clk), 
        .rst(rst), 
        .Q(Q), 
        .Qb(Qb)
    );

    // Faz o clock oscilar de 5 em 5 nanosegundos de forma infinita
    always #5 clk = ~clk;

    initial begin
        $dumpfile("resultado.vcd"); // Cria o arquivo de ondas (que salva a simulação inteira, até o $finish)
        $dumpvars(0, ffd_tb);       // Salva as variáveis do teste

        $display("[Teste] Começou a simulação!");
        
        // Inicializa os sinais
        $display("[Teste] Dando Reset, esperando 12ns");
        rst = 1; // Liga o reset
        D = 0;
        #12;     // Espera passar 12ns
        
        $display("[Teste] Desligando Reset e injetando 1 no Flip-Flop, esperando 10ns");
        rst = 0; // Desliga o reset
        D = 1;   // Injeta 1 no Flip-Flop
        #10;     // Espera passar 10ns (vai pegar uma borda de descida aqui)
        
        $display("[Teste] Injetando 0 no Flip-Flop, esperando 10ns");
        D = 0;   // Muda D para 0
        #10;     // Espera mais 10ns (outra borda de descida)
        
        $display("[Teste] Fim da simulação.");
        $finish; // IMPORTANTE: Para o relógio do simulador, senão ele roda eterno
    end
endmodule