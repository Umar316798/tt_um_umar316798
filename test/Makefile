# Variables
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v
TESTBENCH = tb.v

# Verilog files
VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES)) $(TESTBENCH)

# Build output
SIM_OUT = sim.out

# Icarus Verilog build and run
all:
	iverilog -o $(SIM_OUT) $(VERILOG_SOURCES)
	vvp $(SIM_OUT)
