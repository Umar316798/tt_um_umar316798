export TOPLEVEL_LANG = verilog
export TOPLEVEL = tb
export MODULE = test_project

test:
	pytest --junitxml=results.xml

clean:
	rm -rf sim_build *.vcd *.out results.xml
