`default_nettype none

module tt_um_demux1to4 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    wire Y0, Y1, Y2, Y3;

    demux1to4 dut (
        .D (ui_in[0]),
        .S0(ui_in[1]),
        .S1(ui_in[2]),
        .Y0(Y0),
        .Y1(Y1),
        .Y2(Y2),
        .Y3(Y3)
    );

    assign uo_out = {4'b0000, Y3, Y2, Y1, Y0};

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, clk, rst_n, uio_in};

endmodule

`default_nettype wire