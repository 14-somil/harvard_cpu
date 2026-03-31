`timescale 1ns/1ps

module pc_tb;
    
    reg clk = 0;
    reg reset = 0;
    reg [31:0] next_pc;
    wire [31:0] pc;

    pc pc_inst(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/pc.vcd");
        $dumpvars(0, pc_tb);

        reset = 1; #10;
        reset = 0; next_pc = 32'h4; #10;
        next_pc = 32'h8; #10;
        next_pc = 32'hC; #10;
        next_pc = 32'h10; #10;
        reset = 1; #10;

        $finish;
    end

endmodule   