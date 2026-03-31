`timescale 1ns/1ps

module cu_tb;

    reg [5:0] opcode;

    wire 
        reg_write,
        reg_dst,
        alu_src,
        mem_write,
        mem_read,
        mem_to_reg,
        branch;
    
    wire [2:0] alu_op;

    cu uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .branch(branch)
    );

    initial begin
        $dumpfile("sim/cu.vcd");
        $dumpvars(0, cu_tb);
        
        opcode = 6'b000000; #10; // ADD
        opcode = 6'b000001; #10; // SUB
        opcode = 6'b000010; #10; // AND
        opcode = 6'b000011; #10; // OR
        opcode = 6'b000100; #10; // ADDI
        opcode = 6'b000101; #10; // LW
        opcode = 6'b000110; #10; // SW
        opcode = 6'b000111; #10; // BEQ

        $finish;
    end

endmodule