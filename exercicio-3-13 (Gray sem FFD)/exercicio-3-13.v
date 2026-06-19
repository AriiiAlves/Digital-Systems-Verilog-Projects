module contador_gray(input clk, rst, output [4:0] cont);
    reg [4:0] cont_aux;
    reg bit1 = 1'b1; // 0 [1] (2 estados, aguarda o segundo)
    reg [1:0] bit2 = 2'b10; // 0 1 [10] 11 (4 estados, aguarda o terceiro)
    reg [2:0] bit3 = 3'b100; // 0 1 10 11 [100] 101 110 111 (8 estados, aguarda o quarto)
    reg [3:0] bit4 = 4'b1000; // 0 1 10 11 100 101 110 111 [1000] 1001 1001 1011 1100 1101 1110 1111 (16 estados, aguarda o oitavo)
    reg [4:0] bit5 = 5'b10000; // Mesma lógica

    initial begin
        $display("[ffd] Circuito Contador Gray carregado.");
    end

    always @(negedge(clk) or posedge rst)
    begin
        if (rst == 1'b1)
            begin
                $display("[ffd] Reset Acionado.");

                cont_aux = 5'b00000;
                bit1 = 1'b1; // 0 [1] (2 estados, aguarda o segundo)
                bit2 = 2'b10; // 0 1 [10] 11 (4 estados, aguarda o terceiro)
                bit3 = 3'b100; // 0 1 10 11 [100] 101 110 111 (8 estados, aguarda o quarto)
                bit4 = 4'b1000; // 0 1 10 11 100 101 110 111 [1000] 1001 1001 1011 1100 1101 1110 1111 (16 estados, aguarda o oitavo)
                bit5 = 5'b10000;
            end
        else if (clk == 1'b0)
            begin
                $display("[ffd] Borda de descida detectada! RST = %b | bit1 = %b | bit2 = %b | bit3 = %b | bit4 = %b | bit5 = %b", rst, bit1, bit2, bit3, bit4, bit5);

                if (bit1 == 1'b0) // Se rodou, troca. Se não, mantém.
                    cont_aux[0] = ~cont_aux[0];
                if (bit2 == 2'b00)
                    cont_aux[1] = ~cont_aux[1];
                if (bit3 == 3'b000)
                    cont_aux[2] = ~cont_aux[2];
                if (bit4 == 4'b0000)
                    cont_aux[3] = ~cont_aux[3];
                if (bit5 == 5'b00000)
                    cont_aux[4] = ~cont_aux[4];

                bit1 <= bit1 + 1;
                bit2 <= bit2 + 1;
                bit3 <= bit3 + 1;
                bit4 <= bit4 + 1;
                bit5 <= bit5 + 1;

                $display("[ffd] Novo Valor: cont = %b", cont_aux);
            end        
    end
    
    assign cont = cont_aux;
endmodule

/*
Contador Gray:

00000
00001
00011
00010
00110
00111
00101
00100

1 bit -> 1x0, 2x1, 2x0, 2x1, ...
2 bit -> 2x0, 4x1, 4x0, 4x1, ...
3 bit -> 4x0, 8x1, 8x0, 8x1, ...
4 bit -> 8x0, 16x1, 16x0, 16x1, ...

Eu montei registradores que guardam essa alternância de estados. Como o primeiro sempre inicia na metade da transição sempre com zeros, já inicializo eles manualmente.
*/