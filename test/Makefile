# Variables
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v
TESTBENCH = tb.v

VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES)) $(TESTBENCH)

# Cocotb needs this env var set
export TOPLEVEL_LANG = verilog
export MODULE = test_project  # <-- this must match your test_*.py file name without .py
export TOPLEVEL = tb

# Run test using pytest so we get results.xml
test:
	pytest --junitxml=test/results.xml

clean:
	rm -rf sim_build *.vcd *.out test/results.xml
