module  regtb ();

    reg [31:0] regA,regB;
    reg [4:0] readRegA, readRegB, writeReg;
    reg [31:0] writeData;

    reg RegWrite, RegRead, clk;
    wire [31:0] out32;

    reg [5:0] address;
    reg memwrite, memread;
    reg [31:0] writeData;

    RegFile RegFile1(
        .regA(regA),
        .regB(regB),
        .readRegA(readRegA),
        .readRegB(readRegB),
        .writeReg(writeReg),
        .writeData(writeData),
        .RegWrite(RegWrite),
        .RegRead(RegRead),
        .clk(clk)
    );

    initial begin
    clk = 1'b0;
    repeat (10)
    #5 clk = ~clk;
    $finish;    
    end

    initial begin
        readRegA = 5'b3;
        readRegB = 5'b7;
        writeReg = 5'b7;
        writeData = 32'b1;
        RegWrite = 1'b0;
        RegRead = 1'b0;
        #5;
        readRegA = 5'b0;readRegB=5'b0;writeReg=5'b0;writeData=32'b1;RegWrite = 1'b1; 
        #10
        RegRead = 1'b1;RegWrite = 1'b0; 
        #10 readRegA = 5'b0;writeData=32'b0 ;RegWrite = 1'b1;RegRead = 1'b0;
        #10 RegRead = 1'b1;;RegWrite = 1'b0;

    end
    
endmodule