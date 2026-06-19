# Compilar

Imagine que você tem 2 arquivos na mesma pasta: somador.v (circuito) e tb_somador.v (testbench de teste).

`iverilog -o simulação.vvp somador.v tb_somador.v` -> Quem interliga os arquivos/funções é o próprio compilador.

Isso gera um arquivo simulacao.vvp

Executar simulação: `vvp simulação.vvp`

Ver gráfico de ondas:

```verilog
initial begin
        $dumpfile("resultado.vcd"); // Cria o arquivo de ondas
        $dumpvars(0, ffd_tb);       // Salva as variáveis do teste
        
        $display("[Teste] Começou a simulação!");
        // ... restante do código
```

Depois: `gtkwave resultado.vcd`

Para ver diagrama:

`sudo apt install yosys graphviz`

- Apenas diagrama de estados - `yosys -p "read_verilog <arquivo>.v; proc; opt; show -colors 2 -format svg -prefix esquema <module_escolhido>"`

# Extensões VSCode

1. Verilog-HDL/SystemVerilog/Bluespec: Realce de sintaxe a autocomplete
2. DigitalJS: Permite visualizar o circuito gráfico interativo no VSCode

Obs: DigitalJS não roda se tiver $display.