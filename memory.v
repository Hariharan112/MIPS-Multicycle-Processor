`timescale 1ns / 1ps

module memory (
    output reg [31:0] out32, input [5:0] address , input [31:0] writeData ,input memwrite ,  memread ,clk
    );

    reg [31:0] mem [5:0];

    always @(posedge clk ) begin
        if (memwrite) begin
            mem[address] <= writeData;
        end
    end

    always @(posedge clk) begin
        if (memread) begin
            out32 <= mem[address];
        end
    end

endmodule
