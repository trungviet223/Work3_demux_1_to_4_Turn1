`default_nettype none
`timescale 1ns / 1ps

/* Testbench wrapper de cocotb (test.py) dieu khien va quan sat
 * module top-level tt_um_demux1to4 (dinh nghia trong src/project.v).
 * File nay khong chua logic thiet ke, chi lam nhiem vu noi day tin hieu.
 */
module tb ();

  // Dump song ra file VCD, xem bang GTKWave neu can debug
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Khai bao cac tin hieu khop voi chuan pin cua TinyTapeout
  reg        clk;
  reg        rst_n;
  reg        ena;
  reg  [7:0] ui_in;
  reg  [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  // Chi dung khi chay Gate-Level simulation (sau khi da co netlist that)
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate dung module top-level: tt_um_demux1to4
  tt_um_demux1to4 user_project (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in  (ui_in),    // Dedicated inputs:  D=ui_in[0], S0=ui_in[1], S1=ui_in[2]
      .uo_out (uo_out),   // Dedicated outputs: Y0..Y3 = uo_out[3:0]
      .uio_in (uio_in),   // IOs: Input path (khong dung trong thiet ke nay)
      .uio_out(uio_out),  // IOs: Output path (khong dung)
      .uio_oe (uio_oe),   // IOs: Enable path (khong dung)
      .ena    (ena),      // enable - len cao khi design duoc chon
      .clk    (clk),      // clock (khong dung vi mach thuan to hop)
      .rst_n  (rst_n)     // reset, tich cuc muc thap (khong dung)
  );

endmodule