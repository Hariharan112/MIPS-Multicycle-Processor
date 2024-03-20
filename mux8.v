`timescale 1ns / 1ps

module mux8 (
    output [31:0] out32, input [31:0] in1, in2, in3, in4,in5,in6,in7,in8, input [2:0] sel
    );

    assign out32 = (sel == 3'b000) ? in1 : 
                    (sel == 3'b001) ? in2 : 
                    (sel == 3'b010) ? in3 : 
                    (sel == 3'b011) ? in4 :
                    (sel == 3'b100) ? in5 :
                    (sel == 3'b101) ? in6 :
                    (sel == 3'b110) ? in7 :
                    (sel == 3'b111) ? in8 : 32'bx;

endmodule
