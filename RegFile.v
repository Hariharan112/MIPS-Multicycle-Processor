`timescale 1ns / 1ps
module RegFile (
    output reg [31:0] regA,regB , input [4:0] readRegA, readRegB, writeReg, input [31:0] writeData, input RegWrite , input clk
    );

    reg [31:0] regFile [31:0];

    //intialize the register file
    initial begin
        regFile[1] = 32'h0;
        regFile[2] = 25;
        regFile[3] = 40;
        regFile[5] = 18;
    end

    always @(posedge clk) begin
        if (RegWrite) begin
            regFile[writeReg] <= writeData;
        end
    end

    always @(negedge clk) begin
            regA <= regFile[readRegA];
            regB <= regFile[readRegB];
    end
    
endmodule