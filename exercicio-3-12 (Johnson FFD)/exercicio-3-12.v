// FLIP FLOP D COM RESET
module FFD(input D, clk, rst, output Qb, output reg Q);
    initial begin
        $display("[ffd] Circuito FFD carregado.");
    end

    always @(posedge clk)
    begin
        if (rst == 1'b1) begin
            $display("[ffd] Reset detectado.");
            Q <= 1'b0;
        end
        else begin
            //$display("[ffd] Aplicando D = %b.", D);
            Q <= D;
        end
        
        //$strobe("[ffd] Borda de subida detectada! RST = %b | D = %b | Q = %b", rst, D, Q);
    end

    assign Qb = ~Q;
endmodule

// Deslocador Bidirecional
module contador_johnson(input clk, rst, output [4:0] Q);
    wire [4:0] D; // Wire: Recebe atribuições contínuas (assign). Se for reg, não tem como "soldar".
    wire [4:0] Qb;

    // Assign: "soldando entradas" com portas lógicas.
    assign D[0] = ~Q[4];
    assign D[1] = Q[0];
    assign D[2] = Q[1];
    assign D[3] = Q[2];
    assign D[4] = Q[3];

    // Dando os fios para os inputs do flip flop.
    FFD ffd0 (.D(D[0]), .clk(clk), .rst(rst), .Qb(Qb[0]), .Q(Q[0]));
    FFD ffd1 (.D(D[1]), .clk(clk), .rst(rst), .Qb(Qb[1]), .Q(Q[1]));
    FFD ffd2 (.D(D[2]), .clk(clk), .rst(rst), .Qb(Qb[2]), .Q(Q[2]));
    FFD ffd3 (.D(D[3]), .clk(clk), .rst(rst), .Qb(Qb[3]), .Q(Q[3]));
    FFD ffd4 (.D(D[4]), .clk(clk), .rst(rst), .Qb(Qb[4]), .Q(Q[4]));

    initial begin
        $display("[Cont. John] Circuito Contador Johnson carregado.");
    end

    always @(posedge(clk) or posedge(rst))
    begin
        $display("[Cont. John] Valor atual: %b", Q);
    end
endmodule

/*
ANOTAÇÕES

Com clock, tudo que tem always roda em paralelo.
*/