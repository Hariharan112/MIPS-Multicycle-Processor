`timescale 1ns / 1ps

module  mem_tb ();
    
    reg [5:0] address;
    reg memwrite, memread, clk;
    reg [31:0] writeData;
    wire [31:0] out32;
    
    memory memory1(
        .out32(out32),
        .address(address),
        .writeData(writeData),
        .memwrite(memwrite),
        .memread(memread),
        .clk(clk)
    );
    
    initial begin
    clk = 1'b0;
    repeat (10)
    #5 clk = ~clk;
    $finish;    
    end
    
    initial begin
        address = 6'b0;
        memwrite = 1'b0;
        memread = 1'b0;
        #5;
        address = 6'b0;writeData=32'b1;memwrite = 1'b1; 
        #10
        memread = 1'b1;memwrite = 1'b0; 
        #10 address = 6'b0;writeData=32'b0 ;memwrite = 1'b1;memread = 1'b0;
        #10 memread = 1'b1;;memwrite = 1'b0;
    end

endmodule
