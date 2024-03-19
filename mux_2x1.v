`timescale 1ns / 1ps

//verilog module for 2x1_MUX
module mux_2x1(
    in_0,
    in_1,
    sel,
    Out
    );

    parameter WIDTH = 32;
    input [WIDTH-1:0] in_0;               
    input [WIDTH-1:0] in_1;                
    input sel;              
    output reg [WIDTH-1:0] Out;
    
    always @(*) begin
      case (sel)
        0: 
          Out = in_0;
        1: 
          Out = in_1;
        default: 
          Out = 32'bx; 
      endcase
    end
endmodule


