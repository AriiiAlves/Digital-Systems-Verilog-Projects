module contador_johson(input clk, rst, output [4:0] cont);
    reg [4:0] cont_aux;

    initial begin
        $display("[ffd] Circuito Contador Johnson carregado.");
    end

    always @(negedge(clk) or posedge(rst))
    begin
        if (rst == 1'b1)
            begin
                cont_aux = 5'b10000; // Precisa voltar pra 10000 (se não fica preso em 0 pra sempre)
            end
        else if (clk == 1'b0)
            begin
                cont_aux = {~cont_aux[0], cont_aux[4:1]};
            end
        
        $strobe("[ffd] Borda de descida detectada! RST = %b | cont = %b", rst, cont_aux);
    end

    assign cont = cont_aux;
endmodule

/*
Contador Johnson:

000
001
011
111
110
100
000
*/