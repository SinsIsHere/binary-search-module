`timescale 1ns / 1ps

module testbench;
    reg        clk;
    reg        rst_n;
    reg        EN;
    reg  [7:0] IN;
    wire       found;
    wire       not_found;
    wire [4:0] OUT;

    Binary_Search DUT (
        .IN       (IN),
        .clk      (clk),
        .rst_n    (rst_n),
        .EN       (EN),
        .found    (found),
        .not_found(not_found),
        .OUT      (OUT)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        EN = 0;
        IN = 0;

        #2 rst_n = 1; EN = 1; IN = 190;
        #2 EN = 0;
        #20 EN = 1; IN = 50;
        #4 EN = 0;
        #36 EN = 1; IN = 200;
        #4 EN = 0;


        #40 $finish;
    end
endmodule
