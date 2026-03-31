`timescale 1ns/1ps

module regfile_tb;

    reg clk = 0;
    reg we = 0;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] wd;
    wire [31:0] rd1, rd2;

    regfile regfile_inst(.clk(clk), .we(we), .rs1(rs1), .rs2(rs2), .rd(rd), .wd(wd), .rd1(rd1), .rd2(rd2));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/regfile.vcd");
        $dumpvars(0, regfile_tb);

        we = 1; rd = 5'h0; wd = 32'hA; #10;
        we = 1; rd = 5'h1; wd = 32'hAA; #10;
        we = 1; rd = 5'h2; wd = 32'hAAA; #10;
        we = 1; rd = 5'h3; wd = 32'hAAAA; #10;
        we = 0; rs1 = 5'h0; rs2 = 5'h1; #10;
        we = 0; rs1 = 5'h2; rs2 = 5'h3; #10;

        $finish;
    end

endmodule