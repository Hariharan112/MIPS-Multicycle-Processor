`timescale 1ns / 1ps

module control_tb();

    reg clk;
    reg [5:0] opcode;
    wire PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegDst,RegWrite,ALUSrcA;
    wire [1:0]  ALUSrcB,ALUOp,PCSource;

    control control1(
        .PCWriteCond(PCWriteCond), 
        .PCWrite(PCWrite), 
        .IorD(IorD), 
        .MemRead(MemRead), 
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg), 
        .IRWrite(IRWrite), 
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUOp(ALUOp),
        .PCSource(PCSource),
        .opcode(opcode),
        .clk(clk)
    );

    initial begin
        
        opcode = 6'b000000;
        #40;
        opcode = 6'b100011;
        #50;
        opcode = 6'b000100;
        #30;
        opcode = 6'b000010;
        #30;
        opcode = 6'b101011;
        #40;
        $finish;
       end

    initial begin
        
        clk = 0;
        #5;
        forever #5 clk = ~clk;
        end

endmodule