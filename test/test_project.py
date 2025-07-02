import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def my_simple_test(dut):
    dut._log.info("Starting test")
    dut.clk.value = 0
    dut.ena.value = 1
    dut.rst_n.value = 1
    dut.uio_in.value = 0

    for i in range(4):
        dut.ui_in.value = i
        await Timer(10, units='ns')
        dut._log.info(f"Input: {dut.ui_in.value.bin} Output: {dut.uo_out.value.bin}")
