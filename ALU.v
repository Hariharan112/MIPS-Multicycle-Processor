`timescale 1ns / 1ps

module ALU(output [31:0] out32,output zero,input [31:0] A32,B32, input [2:0] ALUop
);

wire [31:0] and_out, or_out, add_out, sub_out,slt_out,invalid;

//ALU CODES ADD 010, SUB 110, AND 000, OR 001 , SLT 111

assign and_out = A32 & B32;
assign or_out = A32 | B32;
assign add_out = A32 + B32;
assign sub_out = A32 - B32;
assign slt_out = (A32 < B32) ? 32'h00000001 : 32'b0;
assign invalid = 32'bx;

wire [1:0] select;


mux8 m8(
    .out32(out32),
    .in1(and_out),
    .in2(or_out),
    .in3(add_out),
    .in4(invalid),
    .in5(invalid),
    .in6(invalid),
    .in7(sub_out),
    .in8(slt_out),
    .sel(ALUop));

assign zero = (out32 == 32'b0) ? 1'b1 : 1'b0;
    
endmodule
