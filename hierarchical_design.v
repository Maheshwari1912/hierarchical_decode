module decoder_1to2 (
    input logic A,
    output logic [1:0] Y
);
    assign Y = (A == 1'b0) ? 2'b01 : 2'b10;
endmodule

module decoder_2to4 (
    input logic [1:0] A,
    input logic enable,
    output logic [3:0] Y
);
    always_comb begin
        if (enable) begin
            case (A)
                2'b00: Y = 4'b0001;
                2'b01: Y = 4'b0010;
                2'b10: Y = 4'b0100;
                2'b11: Y = 4'b1000;
                default: Y = 4'b0000;
            endcase
        end else begin
            Y = 4'b0000;
        end
    end
endmodule


module decoder_3to8 (
    input logic [2:0] A,
    output logic [7:0] Y
);
    logic [1:0] enable;
    logic [3:0] Y0, Y1;

    // 1-to-2 decoder to generate enable signals
    decoder_1to2 enable_decoder (
        .A(A[2]),
        .Y(enable)
    );

    // Two 2-to-4 decoders
    decoder_2to4 lower_decoder (
        .A(A[1:0]),
        .enable(enable[0]),
        .Y(Y0)
    );

    decoder_2to4 upper_decoder (
        .A(A[1:0]),
        .enable(enable[1]),
        .Y(Y1)
    );

    // Combine outputs from both decoders
    assign Y = {Y1, Y0};

endmodule
