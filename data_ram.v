module data_ram (
    input clk,
    input en, we,
    input [9:0] addr,
    input [18:0] din,
    output reg [18:0] dout
);
    reg [18:0] mem [0:1023];

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            mem[i] = 19'd0;
    end

    always @(posedge clk) begin
        if (en) begin
            if (we) begin
                mem[addr] <= din;
                $display("STORE: Mem[%0d] <= %0d at time %0t", addr, din, $time);
            end
            dout <= mem[addr];
            if (!we) begin
                $display("LOAD: R? <= Mem[%0d] (%0d) at time %0t", addr, mem[addr], $time);
            end
        end
    end
endmodule
