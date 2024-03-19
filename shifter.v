module shifter(
    input [31:0] in,
    output [31:0] shifted
    );

    assign shifted = in << 2;

endmodule