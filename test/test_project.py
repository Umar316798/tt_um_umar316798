import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue  # Import BinaryValue

@cocotb.test()
async def my_simple_test(dut):
    dut._log.info("Starting test")
    dut.clk.value = 0
    dut.ena.value = 1
    dut.rst_n.value = 1
    dut.uio_in.value = 0

    for i in range(4):
        # Create a BinaryValue for i with the appropriate width (assuming ui_in is 2 bits)
        dut.ui_in.value = BinaryValue(i, n_bits=2)
        await Timer(10, units="ns")
        dut._log.info(f"Input: {dut.ui_in.value.bin} Output: {dut.uo_out.value.bin}")
