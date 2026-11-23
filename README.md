# Asynchronous FIFO Design in Verilog

## Overview

This project contains a Verilog implementation of a 16-entry, 8-bit
asynchronous FIFO.

The FIFO uses separate write and read clocks. Data is written into the
memory in write order and read out in the same order.

## Specifications

  Parameter        Value
  ---------------- -------------------------------
  FIFO depth       16 entries
  Data width       8 bits
  Total storage    128 bits
  Write clock      `w_clk`
  Read clock       `r_clk`
  Reset            Active-low asynchronous reset
  Write enable     `w_en`
  Read enable      `r_en`
  Status outputs   `full`, `empty`

## Design

The design uses:

-   A 16 × 8-bit memory array.
-   5-bit binary read and write pointers. The lower four bits select a
    memory location, while the fifth bit tracks pointer wraparound.
-   Gray-code read and write pointers for clock-domain crossing.
-   Two-flop synchronizers to transfer pointer information between the
    write and read clock domains.
-   `full` and `empty` status flags to indicate when writing or reading
    is not permitted.

The write side is controlled by `w_clk` and the read side is controlled
by `r_clk`.

## Files

-   `asynchronous_fifo.v` --- FIFO RTL design.
-   `asynchronous-fifo_tb.v` --- Verilog testbench.

## Simulation

The design is simulated using Xilinx Vivado.

The testbench exercises reset, basic write and read operations, and the
FIFO full and empty conditions. The waveforms can be used to observe the
clocks, enables, input and output data, and status flags.

## Interface

  Signal           Direction   Description
  ---------------- ----------- -------------------------------
  `w_clk`          Input       Write clock
  `r_clk`          Input       Read clock
  `w_en`           Input       Write enable
  `r_en`           Input       Read enable
  `reset`          Input       Active-low asynchronous reset
  `data_in[7:0]`   Input       Data input
  `d_out[7:0]`     Output      Data output
  `full`           Output      FIFO full status
  `empty`          Output      FIFO empty status

------------------------------------------------------------------------
