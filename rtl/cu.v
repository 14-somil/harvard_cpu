module cu (
    input  [5:0] opcode,

    output reg reg_write,
    output reg reg_dst, //0 = rd from I-type, 1 = rd from R-type
    output reg alu_src, //0 = rs2, 1 = immediate

    output reg [2:0] alu_op,

    output reg mem_write,
    output reg mem_read,
    output reg mem_to_reg, //1 = load result, 0 = ALU result

    output reg branch
);
    localparam ADD  = 6'b000000;
    localparam SUB  = 6'b000001;
    localparam AND_ = 6'b000010;
    localparam OR_  = 6'b000011;

    localparam ADDI = 6'b000100;
    localparam LW   = 6'b000101;
    localparam SW   = 6'b000110;

    localparam BEQ  = 6'b000111;

    always @(*) begin
        case (opcode)
            ADD: begin
                reg_write = 1;
                reg_dst = 1;
                alu_src = 0;
                alu_op = 3'b000;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

            SUB: begin
                reg_write = 1;
                reg_dst = 1;
                alu_src = 0;
                alu_op = 3'b001;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

            AND_: begin
                reg_write = 1;
                reg_dst = 1;
                alu_src = 0;
                alu_op = 3'b010;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

            OR_: begin
                reg_write = 1;
                reg_dst = 1;
                alu_src = 0;
                alu_op = 3'b011;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

            ADDI: begin
                reg_write = 1;
                reg_dst = 0;
                alu_src = 1;
                alu_op = 3'b000;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

            LW: begin
                reg_write = 1;
                reg_dst = 0;
                alu_src = 1;
                alu_op = 3'b000;
                mem_write = 0;
                mem_read = 1;
                mem_to_reg = 1;
                branch = 0;
            end

            SW: begin
                reg_write = 0;
                reg_dst = 0; // Don't care
                alu_src = 1;
                alu_op = 3'b000;
                mem_write = 1;
                mem_read = 0;
                mem_to_reg = 0; // Don't care
                branch = 0;
            end

            BEQ: begin
                reg_write = 0;
                reg_dst = 0; // Don't care
                alu_src = 0;
                alu_op = 3'b001; // SUB for comparison
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0; // Don't care
                branch = 1;
            end

            default: begin
                reg_write = 0;
                reg_dst = 0;
                alu_src = 0;
                alu_op = 3'b000;
                mem_write = 0;
                mem_read = 0;
                mem_to_reg = 0;
                branch = 0;
            end

        endcase
    end
    
endmodule