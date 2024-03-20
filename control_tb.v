endmodule

module control_tb()

//test the module for the different states

    reg clk;
    reg [5:0] opcode;
    wire PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegDst,RegWrite,ALUSrcA, ALUSrcB,ALUOp,PCSource;

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
        clk = 0;
        opcode = 6'b000000;
        #40;
        opcode = 6'b100011;
        #50;
        opcode = 6'b000100;
        #30;
        opcode = 6'b000010;
        #30;
        opcode = 6'b101011
        #40;
        $finish;



    end

    always begin
         clk = ~clk #5;
    end

endmodule