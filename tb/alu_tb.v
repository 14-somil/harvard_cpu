`timescale 1ns/1ps

module alu_tb;

    reg [31:0] a, b;
    reg [2:0] op;
    wire [31:0] result;

    alu uut (.a(a), .b(b), .op(op), .result(result));

    initial begin
        $dumpfile("sim/alu.vcd");
        $dumpvars(0, alu_tb);
        
        a = 10;
        b = 5;
        op = 3'b000; #10;
        op = 3'b001; #10;
        op = 3'b010; #10;
        op = 3'b011; #10;

        $finish;
    end
endmodule