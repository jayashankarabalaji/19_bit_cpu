module instr_rom #(
    parameter ADDR_WIDTH = 10,          
    parameter DATA_WIDTH = 19
)(
    input  wire                  clk,
    input  wire [ADDR_WIDTH-1:0] addr,
    output reg  [DATA_WIDTH-1:0] dout
);

    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    initial begin

        $readmemb("program.mem", mem);
    end


    always @(posedge clk) begin
        dout <= mem[addr];
    end

endmodule
