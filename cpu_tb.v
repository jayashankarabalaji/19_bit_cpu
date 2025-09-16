`timescale 1ns/1ps  
module cpu_tb;

    reg clk;
    reg reset;

    wire [9:0] pc_out;
    wire [18:0] r1_out;
    wire [18:0] r2_out;
    wire [18:0] r3_out;

    cpu_top DUT (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .r1_out(r1_out),
        .r2_out(r2_out),
        .r3_out(r3_out)
    );

    always #5 clk = ~clk;

    initial begin
        $display("Starting 19-bit CPU simulation...");
        clk   = 0;
        reset = 1;

        #10 reset = 0;

        $monitor("Time=%0t | PC=%0d | R1=%0d | R2=%0d | R3=%0d",
                 $time, pc_out, r1_out, r2_out, r3_out);

        #200 $finish;
    end

endmodule
