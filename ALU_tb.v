`timescale 1ns / 1ps

module ALU_tb ();

    reg [31:0] A32, B32;
    reg [3:0] ALUop;
    wire [31:0] out32;
    wire zero;
    
    ALU ALU1(
        .out32(out32),
        .zero(zero),
        .A32(A32),
        .B32(B32),
        .ALUop(ALUop)
    );
    
    initial begin
        A32 = 32'b0111;
        B32 = 32'b0011;
        ALUop = 3'b000;
        #10  ALUop = 3'b001;
        #10  ALUop = 3'b010;
        #10  ALUop = 3'b110;
        #10;
        $finish;
    end
endmodule
