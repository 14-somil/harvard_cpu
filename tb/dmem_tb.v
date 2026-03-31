`timescale 1ns/1ps

module dmem_tb;

    reg clk = 0;
    reg we = 0;
    reg [31:0] addr;
    reg [31:0] wd;
    wire [31:0] rd;

    dmem dmem_inst(.clk(clk), .we(we), .addr(addr), .wd(wd), .rd(rd));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/dmem.vcd");
        $dumpvars(0, dmem_tb);

        we = 1; addr = 32'h0; wd = 32'hA; #10;
        we = 1; addr = 32'h4; wd = 32'hAA; #10;
        we = 1; addr = 32'h8; wd = 32'hAAA; #10;
        we = 1; addr = 32'hC; wd = 32'hAAAA; #10;
        we = 0; addr = 32'h0; wd = 32'hA; #10;
        we = 0; addr = 32'h4; wd = 32'hA; #10;
        we = 0; addr = 32'h8; wd = 32'hA; #10;

        $finish;
    end
endmodule