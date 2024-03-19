`timescale 1ns / 1ps

module mux4 (
    output [31:0] out32, input [31:0] in1, in2, in3, in4, input [2:0] sel
    );

    assign out32 = (sel == 3'b000) ? in1 : 
                  (sel == 3'b001) ? in2 : 
                  (sel == 3'b010) ? in3 : 
                  (sel == 3'b011) ? in4 : 32'b0;
    
endmodule
