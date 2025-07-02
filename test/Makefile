# Required for Cocotb
export TOPLEVEL_LANG = verilog
export MODULE = test_project   # test_project.py
export TOPLEVEL = tb           # your tb.v

test:
	pytest --junitxml=test/results.xml

clean:
	rm -rf sim_build *.vcd *.out test/results.xml
