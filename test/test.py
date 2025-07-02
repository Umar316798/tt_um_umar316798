import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def simple_test(dut):
    """A simple example test"""
    dut._log.info("Running simple test")
    await Timer(10, units='ns')
    assert True

