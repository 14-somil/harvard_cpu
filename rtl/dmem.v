module dmem (
    input clk,
    input we,
    input [31:0] addr,
    input [31:0] wd,
    output [31:0] rd
);
    reg [31:0] memory [0:255];

    integer i;
    initial begin
        for(i = 0; i<256; i++)
            memory[i] = 32'b0;
    end

    assign rd = memory[addr >> 2];

    always @(posedge clk) begin
        if(we)
            memory[addr >> 2] <= wd;
    end

endmodule