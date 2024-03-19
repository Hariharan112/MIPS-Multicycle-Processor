module sign_extend(
    input [15:0] Imm,
    output reg [31:0] extended
    );

    always @(*) begin
        extended[31:0] <= { {16{Imm[15]}}, Imm[15:0]};
    end

endmodule

