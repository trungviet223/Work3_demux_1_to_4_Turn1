## How it works

This project implements a 1-to-4 demultiplexer (demux) using only NAND2 and
INV (inverter) primitives, without relying on any pre-built 1:2 demux blocks.

The design uses 3 inputs (D, S1, S0) and produces 4 outputs (Y0..Y3), where
exactly one output equals D and the other three are forced to 0, based on
the 2-bit select code {S1, S0}:

| S1  | S0  | Active output |
| --- | --- | ------------- |
| 0   | 0   | Y0 = D        |
| 0   | 1   | Y1 = D        |
| 1   | 0   | Y2 = D        |
| 1   | 1   | Y3 = D        |

Internally, each AND function needed for the demux logic is built from a
NAND2 gate followed by an INV gate (since AND(A,B) = INV(NAND(A,B))). Two
intermediate signals, p = D & ~S1 and q = D & S1, are computed once and
reused for two outputs each (p feeds Y0/Y1, q feeds Y2/Y3), reducing the
total gate count compared to computing each branch independently.

## How to test

The design is purely combinational (no clock is used). To test it:

1. Set `ui_in[0]` = D, `ui_in[1]` = S0, `ui_in[2]` = S1.
2. Wait a few nanoseconds for the combinational logic to settle.
3. Read `uo_out[0]` = Y0, `uo_out[1]` = Y1, `uo_out[2]` = Y2, `uo_out[3]` = Y3.
4. Verify that exactly one of Y0..Y3 equals D (matching the {S1,S0} select
   code above) and the remaining three outputs are 0.

The included cocotb testbench (`test/test.py`) automatically sweeps all 8
combinations of D, S1, and S0, and additionally checks that all outputs
stay at 0 whenever D = 0, regardless of the select value.

## External hardware

No external hardware is required. All inputs and outputs can be driven and
observed directly through the standard TinyTapeout ui_in/uo_out pins (e.g.
using switches/LEDs on a TinyTapeout demo board, or via the on-chip test
harness).
