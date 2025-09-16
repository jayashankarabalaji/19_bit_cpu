module register_file (
    input clk,
    input we,
    input [3:0] raddr1, raddr2, waddr,
    input [18:0] wdata,
    output [18:0] rdata1,
    output [18:0] rdata2,

    output [18:0] dbg_r1,
    output [18:0] dbg_r2,
    output [18:0] dbg_r3
);
    reg [18:0] regs [15:0];

    assign rdata1 = (raddr1 == 4'd0) ? 19'd0 : regs[raddr1];
    assign rdata2 = (raddr2 == 4'd0) ? 19'd0 : regs[raddr2];

    assign dbg_r1 = regs[1];
    assign dbg_r2 = regs[2];
    assign dbg_r3 = regs[3];

    always @(posedge clk) begin
        if (we && (waddr != 4'd0)) begin
            regs[waddr] <= wdata;
            $display("WRITE: R[%0d] <= %d at time %0t", waddr, wdata, $time);
        end
    end
endmodule
