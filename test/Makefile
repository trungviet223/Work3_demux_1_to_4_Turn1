# Makefile cho cocotb + Icarus Verilog
# LUU Y: file nay KHONG chua bat ky dong lenh (recipe) nao can TAB,
# de tranh loi "missing separator" du ban sua qua GitHub web editor
# hay bat ky trinh soan thao nao khac vo tinh chuyen tab thanh space.

ifndef PDK_ROOT
PDK_ROOT := $(shell python3 -c "import volare;print(volare.get_volare_home())")/sky130
endif

ifneq ($(GATES),yes)
$(info Running RTL simulation)
SIM_BUILD := sim_build/rtl
VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(PWD)/../src/demux1to4.v
VERILOG_SOURCES += $(PWD)/../src/project.v
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DFUNCTIONAL
else
$(info Running Gate Level simulation)
SIM_BUILD := sim_build/gl
COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1

VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v
endif

TOPLEVEL := tb
MODULE := test
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

include $(shell cocotb-config --makefiles)/Makefile.sim