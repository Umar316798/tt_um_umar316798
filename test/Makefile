# Makefile for pure Icarus Verilog simulation

# Verilog sources
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v
TB_SOURCES = tb.v

VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES)) $(TB_SOURCES)

# Build directory
SIM_BUILD = sim_build/rtl

# Top module
TOPLEVEL = tb

# Icarus Verilog compile and run
sim:
	mkdir -p $(SIM_BUILD)
	iverilog -o $(SIM_BUILD)/sim.vvp -g2012 -s $(TOPLEVEL) $(VERILOG_SOURCES)
	vvp $(SIM_BUILD)/sim.vvp
