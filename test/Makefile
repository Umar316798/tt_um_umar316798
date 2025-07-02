PROJECT ?= tt_um_umar316798
SRC = ./src
TEST = ./test
BUILD = ./build

export TOPLEVEL_LANG = verilog
export TOPLEVEL = tb
export MODULE = test_project

.PHONY: all clean lint test

all: test

test:
	pytest --junitxml=$(TEST)/results.xml

clean:
	rm -rf $(BUILD) $(TEST)/results.xml
