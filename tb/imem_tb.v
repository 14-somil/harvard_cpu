`timescale 1ns/1ps

module imem_tb;

    reg clk = 1;
    reg [31:0] addr;
    wire [31:0] instr;

    imem imem_inst(.addr(addr), .instr(instr));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/imem.vcd");
        $dumpvars(0, imem_tb);

        addr = 32'h0; #10;
        addr = 32'h4; #10;
        addr = 32'h8; #10;
        addr = 32'hC; #10;
        addr = 32'h10; #10;
        addr = 32'h14; #10;
        addr = 32'h18; #10;
        addr = 32'h1C; #10;

        $finish;
    end
endmodule