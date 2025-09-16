module control_unit (
    input  [4:0] opcode,
    output reg [3:0] alu_op,
    output reg alu_src,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg
);
    always @(*) begin
        alu_op     = 4'b0000;
        alu_src    = 0;
        reg_write  = 0;
        mem_read   = 0;
        mem_write  = 0;
        mem_to_reg = 0;

        case (opcode)
            5'b00000: begin alu_op=4'b0000; reg_write=1; end 
            5'b00001: begin alu_op=4'b0001; reg_write=1; end 
            5'b00010: begin alu_op=4'b0010; reg_write=1; end 
            5'b00011: begin alu_op=4'b0011; reg_write=1; end 
            5'b00100: begin alu_op=4'b0100; reg_write=1; end 
            5'b00101: begin alu_op=4'b0101; reg_write=1; end 
            5'b00110: begin alu_op=4'b0110; reg_write=1; end 
            5'b00111: begin alu_op=4'b0111; reg_write=1; end 
            5'b01000: begin alu_op=4'b0000; alu_src=1; reg_write=1; end 
            5'b01001: begin alu_op=4'b0001; alu_src=1; reg_write=1; end 
            5'b01010: begin alu_op=4'b0000; alu_src=1; mem_read=1; reg_write=1; mem_to_reg=1; end
            5'b01011: begin alu_op=4'b0000; alu_src=1; mem_write=1; end 
            default: ; 
        endcase
    end
endmodule
