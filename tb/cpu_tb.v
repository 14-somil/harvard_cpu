`timescale 1ns/1ps

module cpu_tb;

    reg clk;
    reg reset;

    // Instantiate CPU
    cpu uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    initial begin
        $monitor("Time=%0t PC=%h", $time, uut.pc);
    end

    initial begin
        // Dump waveform
        $dumpfile("sim/cpu.vcd");
        $dumpvars(0, cpu_tb);

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