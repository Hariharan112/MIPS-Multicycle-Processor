`timescale 1ns / 1ps
module ALU_control(
    input [5:0] FF,
    input [1:0] ALUop,
    output reg [2:0] ALU_control
    );

    always @(*) begin
        casex (ALUop)
            2'b00: 
                ALU_control = 3'b010; //Add
            2'b01: 
                ALU_control = 4'b110; //Subtract
            2'b1x: 
                casex(FF)
                    6'bxx0000:
                        ALU_control = 3'b010; //Add
                    6'bxx0010:
                        ALU_control = 3'b110; //Subtract
                    6'bxx0100:
                        ALU_control = 3'b000; //AND
                    6'bxx0101:
                        ALU_control = 3'b001; //OR
                    6'bxx1010:
                        ALU_control = 3'b111; //SLT
                    default:
                        ALU_control = 3'bxxx; //Invalid
                endcase
            default:
                ALU_control = 3'bxxx; //Invalid
        endcase
    end
endmodule
