module cpu_top (
    input clk,
    input reset,
    output [9:0] pc_out,     
    output [18:0] r1_out,   
    output [18:0] r2_out,    
    output [18:0] r3_out     
);
   
    reg [9:0] pc;
    assign pc_out = pc;

    wire [18:0] instr;

    wire [4:0] opcode = instr[18:14];
    wire [3:0] rd     = instr[13:10];
    wire [3:0] rs1    = instr[9:6];
    wire [3:0] rs2    = instr[5:2];
    wire [5:0] imm6   = instr[5:0];   

    
    wire [3:0] alu_op;
    wire alu_src, reg_write, mem_read, mem_write, mem_to_reg;

   
    wire [18:0] rdata1, rdata2, alu_b, alu_y, mem_dout, wb_data;
    wire zero;

   
    instr_rom ROM (
        .clk(clk),
        .addr(pc),
        .dout(instr)
    );

    
    control_unit CU (
        .opcode(opcode),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg)
    );

   
    register_file RF (
        .clk(clk),
        .we(reg_write),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd),
        .wdata(wb_data),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .dbg_r1(r1_out),
        .dbg_r2(r2_out),
        .dbg_r3(r3_out)
    );

    assign alu_b = alu_src ? {{13{imm6[5]}}, imm6} : rdata2;

    alu ALU (
        .alu_op(alu_op),
        .a(rdata1),
        .b(alu_b),
        .y(alu_y),
        .zero(zero)
    );

    data_ram RAM (
        .clk(clk),
        .en(mem_read | mem_write),
        .we(mem_write),
        .addr(alu_y[9:0]),   
        .din(rdata2),        
        .dout(mem_dout)
    );

    assign wb_data = mem_to_reg ? mem_dout : alu_y;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc + 1;
    end
endmodule
