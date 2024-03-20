`timescale 1ns / 1ps

module riscp_tb;
    reg clk;
    riscp riscp1(
        .clk(clk)
    );

    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    initial begin
    #80;
    $finish;
    end
endmodule