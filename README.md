# Asynchronous FIFO in Verilog

A Verilog implementation of a **16-word × 8-bit asynchronous FIFO** with
independent write and read clock domains.

## Overview

An asynchronous FIFO allows data to be written using one clock and read
using another. It follows the **First-In, First-Out (FIFO)** principle:
the first data written is the first data read.

This project is intended to practise RTL design and basic
simulation-based verification of an asynchronous FIFO.

## Design Specifications

  Feature            Specification
  ------------------ -----------------------------------------
  FIFO depth         16 entries
  Data width         8 bits
  Storage capacity   128 bits
  Write clock        Independent write clock (`w_clk`)
  Read clock         Independent read clock (`r_clk`)
  Reset              Active-low asynchronous reset (`reset`)
  Write control      `w_en`
  Read control       `r_en`
  Status flags       `full`, `empty`

## Design Concepts

-   **Separate clock domains:** Writing and reading are controlled by
    independent clocks.
-   **Binary pointers:** The read and write pointers are 5 bits wide.
    Four lower bits select one of the 16 memory locations, and the fifth
    bit tracks wraparound.
-   **Gray-code pointers:** Gray-coded pointer values are used when
    transferring pointer information between clock domains.
-   **Two-flop synchronizers:** Pointer information crossing into the
    other clock domain passes through two flip-flops to reduce the
    chance of metastability propagating.
-   **FULL and EMPTY flags:** The flags indicate when the FIFO cannot
    accept another write or has no data available to read.

## Project Files

``` text
verilog-asynchronous-fifo/
├── rtl/
│   └── asy_fifo.v
├── testbench/
│   └── fifo_tb.v
└── README.md
```

The folder names above are a suggested organization. If the files are
uploaded in the repository root, the README can be updated to match.

## Simulation

The design and testbench can be simulated in **Xilinx Vivado**.

1.  Add `asy_fifo.v` as a design source.
2.  Add `fifo_tb.v` as a simulation source.
3.  Set the testbench module (`asy_fifio_tb`, or the exact module name
    in your file) as the simulation top.
4.  Run **Behavioral Simulation**.
5.  Observe the write/read clocks, enables, pointers, data output, and
    FULL/EMPTY flags in the waveform.

## Testbench Goals

The testbench is intended to exercise:

-   Reset behaviour.
-   Basic write and read operations.
-   FIFO capacity and the FULL condition.
-   Reading stored data and the EMPTY condition.
-   Attempts to write when full and read when empty.

The testbench and RTL should be checked together in simulation. Confirm
that the 17th write is rejected when the FIFO is full, the 17th read is
rejected when it is empty, and the output data matches the order of
accepted writes.

## Learning Outcomes

Through this project, I am practising:

-   FIFO pointer management and wraparound.
-   Binary-to-Gray code conversion.
-   Clock-domain crossing concepts.
-   Two-flop synchronizers.
-   FULL/EMPTY flag generation.
-   Verilog testbench development and waveform debugging.

------------------------------------------------------------------------

**Note:** This is a learning project. The RTL and testbench may be
refined as verification progresses.
