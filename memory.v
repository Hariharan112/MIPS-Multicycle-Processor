`timescale 1ns / 1ps

module memory (
    output reg [31:0] out32, input [5:0] address , input [31:0] writeData ,input memwrite ,  memread ,clk
    );

    reg [31:0] mem [49:0];

    //intialize first 3 memory locations with add instruction using reg file address 1,2,3 ; 4,5,6 ; 7,8,9 in hex with add having 6 opcode 000000 and rs rt rd as next 3 5 bit addresses and 00000 as shamt and 100000 as funct
    // in hex


    initial begin
        mem[0] = 32'h00A11822;
    end



    always @(posedge clk ) begin
        if (memwrite) begin
            mem[address] <= writeData;
        end
    end

     always @(* )  begin
        if (memread) begin
            out32 <= mem[address];
        end
    end

endmodule
