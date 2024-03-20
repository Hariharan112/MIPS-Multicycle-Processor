`timescale 1ns / 1ps

module riscp  (
    input clk
);

    reg [31:0] PC , IR,  MDR , A, B, ALUout;

    initial begin
        PC = 32'h00000000;

    end

    //Control Signals
//    wire PCWriteCond =0, PCWrite =1, IorD =0 , MemRead =1 , MemWrite = 0, MemtoReg =0 , IRWrite =1 , RegDst = 0 ,RegWrite = 0,ALUSrcA=0;
//    wire [1:0] ALUSrcB = 2'b01, ALUOp = 2'b00, PCSource = 2'b00;

    wire PCWriteCond , PCWrite , IorD  , MemRead  , MemWrite , MemtoReg  , IRWrite  , RegDst ,RegWrite,ALUSrcA;
    wire [1:0] ALUSrcB , ALUOp , PCSource ;




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
        .RegWrite(RegWrite),
        .clk(clk)
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
        .RegWrite(RegWrite),
        .readRegB(IR[20:16]),
        .readRegA(IR[25:21]),
        .writeReg(WriteReg),
        .writeData(regwriteData),
        .regA(ReadDataA),
        .regB(ReadDataB)
    );

    wire [31:0] final_address;
    wire [31:0] memreadData;

    memory memory1(
        .clk(clk),
        .address(final_address),
        .writeData(writeData),
        .memwrite(B),
        .memread(MemRead),
        .out32(memreadData)
    );

    wire [31:0] finalA, finalB;
    wire zero;
    wire [31:0] ALU_result;

    ALU alu(
        .out32(ALU_result),
        .zero(zero),
        .A32(finalA),
        .B32(finalB),
        .ALUop(alucontrol)
    );

    wire [31:0] extended;

    sign_extend signExtend(
        .Imm(IR[15:0]),
        .extended(extended)
    );

    wire [31:0 ] shifted;

    shifter shifter1(
        .in(extended),
        .shifted(shifted)
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
        .in_0(ALU_result),
        .in_1(ALUout),
        .in_2(jump_address),
        .in_3(invalid),
        .sel(PCSource),
        .Out(nextPC)
    );

    mux_2x1 muxA(
        .in_0(PC),
        .in_1(A),
        .sel(ALUSrcA),
        .Out(finalA)
    );

    mux_4x1 muxB(
        .in_0(B),
        .in_1(4),
        .in_2(extended),
        .in_3(shifted),
        .sel(ALUSrcB),
        .Out(finalB)
    );

    mux_2x1 muxwriteregno(
        .in_0(IR[20:16]),
        .in_1(IR[15:11]),
        .sel(RegDst),
        .Out(WriteReg)
    );

    mux_2x1  muxregwritedata(
        .in_0(ALUout),
        .in_1(MDR),
        .sel(MemtoReg),
        .Out(regwriteData)
    );

    mux_2x1 muxmemaddress(
        .in_0(PC),
        .in_1(ALU_result),
        .sel(IorD),
        .Out(final_address)
    );

    always @ (posedge clk) begin
        #1;
        MDR <= memreadData;
        ALUout <= ALU_result;
        A <= ReadDataA;
        B <= ReadDataB;

        if (IRWrite) begin
            IR <= memreadData;
        end
        if (PCWriteCond) begin
            if (zero) begin
                PC <= nextPC;
            end
        end
        else if (PCWrite) begin
            PC <= nextPC;
        end 
              

    end


endmodule



