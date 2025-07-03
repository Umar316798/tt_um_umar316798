# Project variables
# Define the root project name, used for top-level module and build directories.
PROJECT ?= tt_um_umar316798
# Source directory where your Verilog files are located.
SRC = ./src
# Test directory where your Python test files are located.
TEST = ./test
# Build directory for simulation artifacts (e.g., compiled Verilog, VCD files).
BUILD = ./build

# Simulation variables for cocotb
# SIM specifies the Verilog simulator to use (e.g., icarus for Icarus Verilog, verilator, ghdl, vcs, xcelium).
# You can change this if you use a different simulator.
export SIM ?= icarus
# TOPLEVEL_LANG specifies the language of your top-level design module.
export TOPLEVEL_LANG ?= verilog
# TOPLEVEL is the name of your top-level Verilog module.
# This MUST match the module name inside your tt_um_umar316798.v file (e.g., module tt_um_umar316798(...);).
export TOPLEVEL ?= tt_um_umar316798
# MODULE specifies the Python test module to run.
# If your test file is test/test_project.py, then MODULE should be test_project.
export MODULE ?= test_project

# List all your Verilog source files here.
# Make sure to include all .v files that are part of your design.
VERILOG_SOURCES = $(SRC)/tt_um_umar316798.v

# Add your test directory to PYTHONPATH so cocotb can find your test modules.
# This is crucial for cocotb to locate your Python test files.
export PYTHONPATH := $(TEST):$(PYTHONPATH)

# Phony targets
# .PHONY declares targets that are not actual files, ensuring they run even if a file with the same name exists.
.PHONY: all clean sim

# The default target when you run 'make' without arguments.
all: sim

# The 'sim' target runs the cocotb simulation.
sim:
	@echo "Running cocotb simulation..."
	# cocotb-run is the command-line utility provided by cocotb.
	# It uses the environment variables (SIM, TOPLEVEL, TOPLEVEL_LANG, MODULE, VERILOG_SOURCES, PYTHONPATH)
	# to set up and execute the simulation.
	# It will automatically discover and run the tests defined in the Python module specified by MODULE.
	cocotb-run
	@echo "Simulation complete."

# The 'clean' target removes all generated build and simulation artifacts.
clean:
	@echo "Cleaning up build and simulation artifacts..."
	# Remove the build directory.
	rm -rf $(BUILD)
	# Remove any JUnit XML results file.
	rm -f results.xml
	# Remove cocotb's simulation build directory.
	rm -rf sim_build
	# Remove log files, VCD (Value Change Dump) files, and FST (Fast Signal Trace) files.
	rm -f *.log *.vcd *.fst
	@echo "Clean complete."
