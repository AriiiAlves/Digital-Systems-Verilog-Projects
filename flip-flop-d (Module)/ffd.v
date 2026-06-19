// FLIP FLOP D COM RESET
module ffd(input D, clk, rst, output Qb, output reg Q);
    initial begin
        $display("[ffd] Circuito FFD carregado.");
    end

    always @(negedge clk)
    begin
        if (rst == 1'b1) begin
            $display("[ffd] Reset detectado.");
            Q <= 1'b0;
        end
        else begin
            $display("[ffd] Aplicando D = %b.", D);
            Q <= D;
        end
        
        $strobe("[ffd] Borda de descida detectada! RST = %b | D = %b | Q = %b", rst, D, Q);
    end

    assign Qb = ~Q;
endmodule

/*
ANOTAÇÕES

- output -> Define que Q é uma saída. 
- reg -> Indica ao compilador que a variável precisa armazenar seu valor até que um próximo evento aconteça. Qualquer variável que receba um valor dentro de um bloco sequencial (como always @(negedge clk) precisa ser do tipo reg.
- always @(negedge clk) -> Dita quando o circuito interno deve reagir. No cqaso, negedge clk = clock passando de 1 pra 0 (negative edge)
- Q <= 1'b0 -> Atribuição não-bloquante (<=): Para circuitos sequencias, usa-se <= em vez de assign Q = ...
- 1'b1 -> 1 = n° bits (1 bit), 'b = base (binária), 1 = valor (0/1 ou x)

- Netlist -> Gera diagrama do circuito digital
- O begin/end é o {} do C.
*/