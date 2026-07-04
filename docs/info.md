yaml_version: 6

project:
title: "1:4 Demultiplexer built from NAND2 and INV gates"
author: "Ten cua ban"
discord: ""
description: "1 to 4 demultiplexer implemented purely with NAND2 and INV primitives (no built-in 1:2 demux blocks used)."
language: "Verilog"
clock_hz: 0

# How many tiles your design occupies? A single tile is about 167x108 uM.

tiles: "1x1"

# Your top module name must start with "tt*um*". Make it unique by including your github username:

top_module: "tt_um_demux1to4"

# List your project's Verilog source files here.

source_files: - "demux1to4.v" - "project.v"

# The pinout of your project. Leave unused pins blank. DO NOT delete or add any pins.

# NOTE: pinout must be a TOP-LEVEL key (sibling of "project"), not nested inside it.

pinout:

# Inputs

ui[0]: "D - data input"
ui[1]: "S0 - select bit 0"
ui[2]: "S1 - select bit 1"
ui[3]: ""
ui[4]: ""
ui[5]: ""
ui[6]: ""
ui[7]: ""

# Outputs

uo[0]: "Y0"
uo[1]: "Y1"
uo[2]: "Y2"
uo[3]: "Y3"
uo[4]: ""
uo[5]: ""
uo[6]: ""
uo[7]: ""

# Bidirectional pins

uio[0]: ""
uio[1]: ""
uio[2]: ""
uio[3]: ""
uio[4]: ""
uio[5]: ""
uio[6]: ""
uio[7]: ""
