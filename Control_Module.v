module  control (
    output reg PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegDst,RegWrite,ALUSrcA, output reg [1:0] ALUSrcB,ALUOp,PCSource, input [5:0] opcode , input clk
    );

    //define 10 possible states in a finite state machine and their corresponding values

    parameter S0 = 4'b0000; //instruction fetch
    parameter S1 = 4'b0001; //instruction decode
    parameter S2 = 4'b0010; //Memory address calculation
    parameter S3 = 4'b0011; //Memory read
    parameter S4 = 4'b0100; //Write back to register file
    parameter S5 = 4'b0101; //Memory write
    parameter S6 = 4'b0110; //Execution
    parameter S7 = 4'b0111; //R type completion
    parameter S8 = 4'b1000; //Branch completion
    parameter S9 = 4'b1001; //Jump completion

    //define the current state and the next state
    reg [3:0] state, nextState;

    state = S0;

    //define the state transition logic
    always @(posedge clk) begin
        state <= nextState;
    end

    //define the next state logic

    //OPCODE: 000000 = R-type, 000100 = beq, 100011 = lw, 101011 = sw , 000010 = j

    always @(*) begin
        case (state)
            S0: begin
                nextState = S1;
                PCWriteCond = 0;
                PCWrite = 1;
                IorD = 0;
                MemRead = 1;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 1;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end
            S1: begin

                if (opcode == 6'b100011 | opcode == 6'b101011) begin
                    nextState = S2;
                end
                else if (opcode == 6'b000000) begin
                    nextState = S6;
                end
                else if (opcode == 6'b000100) begin
                    nextState = S8;
                end
                else begin
                    nextState = S9;
                end
                
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b11;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end
            S2: begin
                if (opcode == 6'b100011) begin
                    nextState = S3;
                end
                else begin
                    nextState = S4;
                end
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 1;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end
            S3: begin
                nextState = S4;
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 1;
                MemRead = 1;
                MemWrite = 0;
                MemtoReg = 1;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end
            S4: begin
                nextState = S0;
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 1;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 1;
                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end

            S5: begin
                nextState = S0;
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 1;
                MemRead = 0;
                MemWrite = 1;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end

            S6: begin
                nextState = S7;
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 1;
                ALUSrcB = 2'b00;
                ALUOp = 2'b10;
                PCSource = 2'b00;
            end

            S7: begin
                nextState = S0;
                PCWriteCond = 0;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 1;
                RegWrite = 1;
                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 2'b00;
                PCSource = 2'b00;
            end

            S8: begin
                nextState = S0;
                PCWriteCond = 1;
                PCWrite = 0;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 1;
                ALUSrcB = 2'b00;
                ALUOp = 2'b01;
                PCSource = 2'b01;
            end

            S9: begin
                nextState = S0;
                PCWriteCond = 0;
                PCWrite = 1;
                IorD = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                IRWrite = 0;
                RegDst = 0;
                RegWrite = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b00;
                ALUOp = 2'b00;
                PCSource = 2'b10;
            end

    
endmodule