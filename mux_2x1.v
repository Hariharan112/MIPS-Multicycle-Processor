//verilog module for N_MUX
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

//testbench for 2:1 mux
module mux_2x1_tb;
    reg [31:0] in_0;
    reg [31:0] in_1;
    reg sel;
    wire [31:0] Out;
    
    mux_2x1 dut (
        .in_0(in_0),
        .in_1(in_1),
        .sel(sel),
        .Out(Out)
    );
    
    initial begin
        $dumpfile("mux_2x1.vcd");
        $dumpvars(0, mux_2x1_tb);

        in_0 = 32'b 0000_0000_0000_0000_0000_0000_0000_0000;
        in_1 = 32'b 1111_1111_1111_1111_1111_1111_1111_1111;
        sel = 0;
        #10;
        sel = 1;
        #10;
        sel = 0;
        #10;
        sel = 1;

        $finish;
    end
endmodule
