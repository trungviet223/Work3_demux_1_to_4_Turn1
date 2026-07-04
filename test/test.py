# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer


async def apply_and_settle(dut, d, s1, s0):
    """Ghi gia tri D, S1, S0 vao ui_in va cho tin hieu on dinh."""
    ui_val = (s1 << 2) | (s0 << 1) | d
    dut.ui_in.value = ui_val
    # Mach thuan hoan toan to hop -> chi can cho vai ns de lan truyen tin hieu
    await Timer(10, units="ns")


def unpack_outputs(dut):
    val = int(dut.uo_out.value)
    y0 = val & 0x1
    y1 = (val >> 1) & 0x1
    y2 = (val >> 2) & 0x1
    y3 = (val >> 3) & 0x1
    return [y0, y1, y2, y3]


def expected_outputs(d, s1, s0):
    sel = (s1 << 1) | s0
    out = [0, 0, 0, 0]
    out[sel] = d
    return out


@cocotb.test()
async def test_demux1to4_exhaustive(dut):
    """Quet toan bo 8 to hop D/S1/S0, kiem tra ngo ra dung nguyen ly demux 1:4."""

    dut._log.info("Bat dau test demux1to4")

    # Day la mach thuan to hop (combinational), khong dung clk/rst,
    # nhung wrapper TinyTapeout van yeu cau cac chan nay -> set gia tri mac dinh.
    dut.ena.value = 1
    dut.rst_n.value = 1
    dut.clk.value = 0
    dut.uio_in.value = 0

    for s1 in range(2):
        for s0 in range(2):
            for d in range(2):
                await apply_and_settle(dut, d, s1, s0)

                got = unpack_outputs(dut)
                exp = expected_outputs(d, s1, s0)

                assert got == exp, (
                    f"Sai tai D={d}, S1={s1}, S0={s0}: "
                    f"expected Y3..Y0={exp[::-1]}, got Y3..Y0={got[::-1]}"
                )

                dut._log.info(
                    f"D={d} S1={s1} S0={s0} -> "
                    f"Y0={got[0]} Y1={got[1]} Y2={got[2]} Y3={got[3]} OK"
                )

    dut._log.info("Tat ca 8 to hop deu dung -> demux1to4 PASS")


@cocotb.test()
async def test_demux1to4_zero_when_d_low(dut):
    """Khi D=0, tat ca Y phai luon = 0 bat ke S1,S0 la gi."""

    dut.ena.value = 1
    dut.rst_n.value = 1
    dut.clk.value = 0
    dut.uio_in.value = 0

    for s1 in range(2):
        for s0 in range(2):
            await apply_and_settle(dut, 0, s1, s0)
            got = unpack_outputs(dut)
            assert got == [0, 0, 0, 0], (
                f"D=0 nhung van co ngo ra len 1 tai S1={s1}, S0={s0}: {got}"
            )
