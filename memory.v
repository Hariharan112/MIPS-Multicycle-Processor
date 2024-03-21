`timescale 1ns / 1ps

module memory (
    output reg [31:0] out32, input [5:0] address , input [31:0] writeData ,input memwrite ,  memread ,clk
    );

    reg [7:0] mem [50:0];

    //intialize first 3 memory locations with add instruction using reg file address 1,2,3 ; 4,5,6 ; 7,8,9 in hex with add having 6 opcode 000000 and rs rt rd as next 3 5 bit addresses and 00000 as shamt and 100000 as funct
    // in hex


    initial begin
        mem[0] = 8'h00;
        mem[1] = 8'h43;
        mem[2] = 8'h08;
        mem[3] = 8'h22;

        mem[4] = 8'h8C;
        mem[5] = 8'hA4;
        mem[6] = 8'h00;
        mem[7] = 8'h06;
        
        mem[24] = 8'h11;
        mem[25] = 8'h11;
        mem[26] = 8'h11;
        mem[27] = 8'h11;
        
    end



    always @(posedge clk ) begin
        if (memwrite) begin
            mem[address] <= writeData[31:24];
            mem[address+1] <= writeData[23:16];
            mem[address+2] <= writeData[15:8];
            mem[address+3] <= writeData[7:0];
        end
    end

     always @(* )  begin
        if (memread) begin
            out32[31:24] <= mem[address];
            out32[23:16] <= mem[address+1];
            out32[15:8] <= mem[address+2];
            out32[7:0] <= mem[address+3];
        end
    end

endmodule
