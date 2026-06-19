// CONTADOR EM ANEL
module contador_anel(input clk, rst, output [3:0] cont);
    reg[3:0] cont_aux;

    always @(posedge(clk), rst)
    begin
        if (rst == 1'b1)
            begin
                cont_aux = 4'b0001; // Precisa voltar pra 0001 (se não fica preso em 0 pra sempre)
            end
        else if (clk == 1'b1)
            begin
                cont_aux = {cont_aux[2:0], cont_aux[3]}; // 
            end
    end

    assign cont = cont_aux;
endmodule

/*
ANOTAÇÕES

- module / endmodule -> Bloco construtor
- begin/end -> {} do C, digamos.
- output [3:0] cont -> Define saída de 4 bits de largura (barramento indexado de 3 até 0: cont[3] ... cont[0])
- reg[3:0] cont_aux: cria registrador interno (salva estado anterior) com 4 bits de largura: cont_aux[3] ... cont_aux[0]).
- always @(posedge(clk), rst) -> Ativa o bloco na borda de subida (positive edge) ou quando o reset mudar de valor

- {cont_aux[2:0], cont_aux[3]} -> Algo como: cont_aux = [cont_aux[2,1,0], cont_aux[3]] -> Bit mais significativo vira o menos significativo

*/