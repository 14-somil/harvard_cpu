`timescale 1ns/1ps

module top_module_tb;

    reg clk;
    reg reset;

    top_module uut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t PC=%h", $time, uut.cpu_inst.pc);
    end

    initial begin
        // Dump waveform
        $dumpfile("sim/top_module.vcd");
        $dumpvars(0, top_module_tb);

        // Init
        clk = 0;
        reset = 1;

        // Reset pulse
        #10;
        reset = 0;

        // Run simulation
        #100;

        // Finish
        $finish;
    end
endmodule