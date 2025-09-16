
module alu (
    input [3:0] alu_op,       
    input [18:0] a,
    input [18:0] b,
    output reg [18:0] y,
    output zero
);

    always @(*) begin
        case (alu_op)
            4'b0000: y = a + b;         
            4'b0001: y = a - b;        
            4'b0010: y = a & b;        
            4'b0011: y = a | b;          
            4'b0100: y = a ^ b;          
            4'b0101: y = ~a;             
            4'b0110: y = a << b[4:0];    
            4'b0111: y = a >> b[4:0];   
            default: y = 19'd0;
        endcase
    end

    assign zero = (y == 19'd0);

endmodule
