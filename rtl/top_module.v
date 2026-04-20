module top_module (
    input clk,
    input reset
);
    //WIRES 

    wire [31:0] instr;
    wire [31:0] imem_addr;

    wire [31:0] dmem_rd;
    wire [31:0] dmem_addr, dmem_wd;
    wire dmem_we;

    //MODULE INSTANTIATIONS
    
    cpu cpu_inst (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .imem_addr(imem_addr),
        .dmem_rd(dmem_rd),
        .dmem_addr(dmem_addr),
        .dmem_wd(dmem_wd),
        .dmem_we(dmem_we)
    );

    dmem dmem_inst (
        .clk(clk),
        .we(dmem_we),
        .addr(dmem_addr),
        .wd(dmem_wd),
        .rd(dmem_rd)
    );

    imem imem_inst (
        .addr(imem_addr),
        .instr(instr)
    );
    
endmodule