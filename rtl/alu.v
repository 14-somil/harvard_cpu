module alu (
    input [31:0] a, b,
    input [2:0] op,
    output reg [31:0] result
);
    always @(*) begin
        case (op)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            default: result = 0; 
        endcase
    end            
endmodule