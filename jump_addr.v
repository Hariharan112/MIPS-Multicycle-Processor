module jump_addr (
    input [31:0] PC,
    input [31:0] IR,
    output reg [31:0] out32
    );
    
    always @(*) begin
        out32[31:28] <= PC[31:28];
        out32[27:0] <= IR[25:0] << 2;
    end
    
endmodule