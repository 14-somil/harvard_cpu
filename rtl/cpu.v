module cpu (
    input clk,
    input reset
);
    // INTERNAL WIRES

    wire [31:0] pc, next_pc;

    wire [31:0] instr;

    wire [5:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [15:0] imm;

    wire [31:0] reg_data1, reg_data2;
    wire [4:0] write_reg;
    wire [31:0] write_data;

    wire [31:0] alu_in2;
    wire [31:0] alu_result;

    wire [31:0] mem_data;

    wire reg_write, reg_dst, alu_src;
    wire [2:0] alu_op;
    wire mem_write, mem_read, mem_to_reg;
    wire branch;

    wire [31:0] imm_ext;
    
    wire branch_taken;

    //INSTRUCTION DECODE

    assign opcode = instr[31:26];
    assign rs1 = instr[25:21];
    assign rs2 = instr[20:16];
    assign rd  = instr[15:11];
    assign imm = instr[15:0];

    //MODULE INSTANTIATIONS

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    imem imem_inst (
        .addr(pc),
        .instr(instr)
    );

    cu cu_inst (
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

    assign write_reg = reg_dst ? rd : rs2;

    regfile regfile_inst (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(write_reg),
        .wd(write_data),
        .rd1(reg_data1),
        .rd2(reg_data2)
    );

    assign imm_ext = {{16{imm[15]}}, imm};

    assign alu_in2 = alu_src ? imm_ext : reg_data2;

    alu alu_inst (
        .a(reg_data1),
        .b(alu_in2),
        .op(alu_op),
        .result(alu_result)
    );

    dmem dmem_inst (
        .clk(clk),
        .we(mem_write),
        .addr(alu_result),
        .wd(reg_data2),
        .rd(mem_data)
    );

    assign write_data = mem_to_reg ? mem_data : alu_result;

    assign branch_taken = branch & (alu_result == 0);

    assign next_pc = branch_taken ? (pc + (imm_ext << 2)) : (pc+4);

endmodule