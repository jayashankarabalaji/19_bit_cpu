`timescale 1ns/1ps   // add timescale for simulation

module cpu_tb;

    // clock + reset
    reg clk;
    reg reset;

    // wires to capture CPU outputs
    wire [9:0] pc_out;
    wire [18:0] r1_out;
    wire [18:0] r2_out;
    wire [18:0] r3_out;

    // Instantiate CPU
    cpu_top DUT (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .r1_out(r1_out),
        .r2_out(r2_out),
        .r3_out(r3_out)
    );

    // Clock generation (10ns period, toggles every 5ns)
    always #5 clk = ~clk;

    initial begin
        $display("Starting 19-bit CPU simulation...");
        clk   = 0;
        reset = 1;

        // release reset after 10ns
        #10 reset = 0;

        // Monitor signals
        $monitor("Time=%0t | PC=%0d | R1=%0d | R2=%0d | R3=%0d",
                 $time, pc_out, r1_out, r2_out, r3_out);

        // Run simulation for 200ns
        #200 $finish;
    end

endmodule
