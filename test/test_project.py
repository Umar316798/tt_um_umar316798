import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_project(dut):
    dut.uio_in.value = 0
    dut.clk.value = 0
    dut.ena.value = 1
    dut.rst_n.value = 1

    dut._log.info("Time | motion door window | alarm")

    for i in range(8):
        dut.ui_in.value = i
        await Timer(10, units='ns')
        dut._log.info(f"{i}: {dut.ui_in.value.bin} -> {dut.uo_out.value.bin}")

    dut._log.info("Test done.")
