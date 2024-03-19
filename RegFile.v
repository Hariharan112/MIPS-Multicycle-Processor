module RegFile (
    output [31:0] regA,regB , input [4:0] readRegA, readRegB, writeReg, input [31:0] writeData, input RegWrite , input RegRead , input clk
    );

    reg [31:0] regFile [31:0];

    always @(posedge clk) begin
        if (RegWrite) begin
            regFile[writeReg] <= writeData;
        end
    end

    always @(negedge clk) begin
        if (RegRead) begin
            regA <= regFile[readRegA];
            regB <= regFile[readRegB];
        end
    end
    
endmodule