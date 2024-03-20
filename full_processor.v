

module riscp  (
    input clk
);

    reg [31:0] PC = 32'b0 , IR,  MDR , A, B, ALUout;

    //Control Signals
    wire PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegDst,RegWrite,ALUSrcA;
    wire [1:0] ALUSrcB, ALUOp, PCSource;

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

    wire [2:0] alucontrol;

    ALU_control aluControlBlock(
        .FF(IR[5:0]),
        .ALUop(ALUOp),
        .ALU_control(alucontrol)
    );

    wire [31:0] regwriteData;
    wire [31:0] WriteReg;
    wire [31:0] ReadDataA, ReadDataB;

    RegFile regFile(
        .clk(clk),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ReadReg1(IR[25:21]),
        .ReadReg2(IR[20:16]),
        .WriteReg(WriteReg),
        .WriteData(regwriteData),
        .ReadData1(ReadDataA),
        .ReadData2(ReadDataB)
    );

    wire [31:0] final_address;
    wire [31:0] memreadData;

    memory memory1(
        .clk(clk),
        .address(final_address),
        .writeData(writeData),
        .memwrite(B),
        .memread(MemRead),
        .readData(memreadData)
    );

    wire [31:0] finalA, finalB;
    wire zero;
    wire [31:0] ALU_result;

    ALU alu(
        .out32(ALU_result),
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

    wire [31:0] jump_address;

    jump_addr jumpAddr1(
        .PC(PC),
        .IR(IR),
        .out32(jump_address)
    );

    wire [31:0] nextPC;
    wire [31:0] invalid = 32'bx;

    mux_4x1 muxPC(
        .in0(ALU_result),
        .in1(ALUout),
        .in2(jump_address),
        .in3(invalid),
        .sel(PCSource),
        .out(nextPC)
    );

    mux_2x1 muxA(
        .in0(ReadDataA),
        .in1(PC),
        .sel(ALUSrcA),
        .out(finalA)
    );

    mux_4x1 muxB(
        .in0(ReadDataB),
        .in1(4),
        .in2(extended),
        .in3(shifted),
        .sel(ALUSrcB),
        .out(finalB)
    );

    mux_2x1 muxwriteregno(
        .in0(IR[20:16]),
        .in1(IR[15:11]),
        .sel(RegDst),
        .out(WriteReg)
    );

    mux_2x1  muxregwritedata(
        .in0(ALUout),
        .in1(MDR),
        .sel(MemtoReg),
        .out(regwriteData)
    );

    mux_2x1 muxmemaddress(
        .in0(PC),
        .in1(ALUout),
        .sel(IorD),
        .out(final_address)
    );

    always @ (posedge clk) begin
        if (PCWriteCond) begin
            if (zero) begin
                PC <= nextPC;
            end
        end
        else if (PCWrite) begin
            PC <= nextPC;
        end

        if (IRWrite) begin
            IR <= memreadData;
        end
        
        MDR <= memreadData;
        A <= finalA;
        B <= finalB;

        ALUout <= ALU_result;
    end



endmodule



//write testbench for this module
module riscp_tb;
    reg clk;
    wire [31:0] PC, IR,  MDR , A, B, ALUout;
    riscp riscp1(
        .clk(clk)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end