`timescale 1ns / 1ps

module ALU(output [31:0] out32,input [31:0] A32,B32, input [2:0] ALUop
);

wire [31:0] and_out, or_out, add_out, sub_out;

//ALU CODES ADD 010, SUB 011, AND 000, OR 001

assign and_out = A32 & B32;
assign or_out = A32 | B32;
assign add_out = A32 + B32;
assign sub_out = A32 - B32;

wire [1:0] select;


mux4 m4(
    .out32(out32),
    .in1(and_out),
    .in2(or_out),
    .in3(add_out),
    .in4(sub_out),
    .sel(ALUop[2:0]));
    
endmodule
