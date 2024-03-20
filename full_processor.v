//The Multi Cycle Processor from prewritten modules

module riscp  (
    input clk
);

    reg [31:0] PC , IR, A, B, ALUout, MDR;

    //Control Signals
    reg PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegDst,RegWrite,ALUSrcA;
    reg [1:0] ALUSrcB, ALUOp, PCSource;

    control controlBlock(
        .opcode(IR[31:26]),
        .RegDst(RegDst),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUOp(ALUOp),
        .PCSource(PCSource),
        .PCWriteCond(PCWriteCond),
        .PCWrite(PCWrite),
        .IorD(IorD),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .IRWrite(IRWrite),
        .RegWrite(RegWrite)
    );

    wire [2:0] ALU_control;

    alu_control aluControlBlock(
        .FF(IR[5:0]),
        .ALUop(ALUOp),
        .ALU_control(ALU_control)
    );

    wire [31:0] regwriteData;
    wire [31:0] WriteReg;

    RegFile regFile(
        .clk(clk),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ReadReg1(IR[25:21]),
        .ReadReg2(IR[20:16]),
        .WriteReg(WriteReg),
        .WriteData(regwriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    wire [31:0] final_address;
    wire [31:0] memwriteData;

    memory memory1(
        .clk(clk),
        .address(final_address),
        .writeData(writeData),
        .memwrite(MemWrite),
        .memread(MemRead),
        .readData(MDR)
    );

    wire [31:0] finalA, finalB;
    
    wire zero;

    ALU alu(
        .out32(ALUout),
        .A32(finalA),
        .B32(finalB),
        .ALUop(ALU_control)
    );

    wire [31:0] extended;

    sign_extend signExtend(
        .in16(IR[15:0]),
        .out32(extended)
    );

    wire [31:0 ] shifted;

    shifter shifter1(
        .in32(extended),
        .out32(shifted)
    );

    wire [31:0] nextPC;

    mux4x1 muxPC(
        .in0(zero),
        .in1(ALUout),
        .in2(shifted),
        .in3(final_address),
        .sel(PCSource),
        .out(nextPC)
    );



endmodule