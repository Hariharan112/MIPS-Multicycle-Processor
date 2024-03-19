//verilog module for 4x1_MUX
module mux_2x1(
    in_0,
    in_1,
    in_2,
    in_3,
    sel,
    Out
    );

    parameter WIDTH = 32;
    input [WIDTH-1:0] in_0;               
    input [WIDTH-1:0] in_1;
    input [WIDTH-1:0] in_2;                
    input [WIDTH-1:0] in_3;                
                
    input [1:0] sel;              
    output reg [WIDTH-1:0] Out;
    
    always @(*) begin
      case (sel)
        0: 
            Out = in_0;
        1: 
            Out = in_1;
        2:
            Out = in_2;
        3:
            Out = in_3;
        default: 
          Out = 32'bx; 
      endcase
    end
endmodule