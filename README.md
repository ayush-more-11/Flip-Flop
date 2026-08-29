# Flip-Flop Implementations in Verilog

A comprehensive collection of sequential logic implementations including D Flip-Flop and T Flip-Flop designs with complete testbenches, schematics, and synthesis results.

## 📋 Overview

This repository contains implementations of two fundamental sequential logic elements:
- **D Flip-Flop (Data Flip-Flop)**: Captures data at the D input on the clock edge
- **T Flip-Flop (Toggle Flip-Flop)**: Toggles its output when T input is high

Both designs include frequency divider circuits to create visible simulation effects and are fully synthesizable for FPGA implementation.

## 🔧 Key Features

- **Two Flip-Flop Types**: D and T flip-flop implementations
- **Frequency Divider**: Built-in clock divider for better simulation visualization (50 MHz → ~2 Hz)
- **Complete Testbenches**: Comprehensive simulation test cases for verification
- **Hardware Verification**: Schematic, synthesis, and simulation results included
- **FPGA Ready**: Synthesizable Verilog code suitable for Xilinx/Altera implementations

## 📁 Project Structure

```
Flip-Flop/
├── D-Flip-Flop/
│   ├── src/
│   │   ├── D_flip_flop.v          # D Flip-Flop main module
│   │   └── D_flip_flop_tb.v       # D Flip-Flop testbench
│   └── results/
│       ├── d_ff_Schematic.jpg     # Schematic diagram
│       ├── d_ff_Synthesis.jpg     # Synthesis results
│       └── d_ff_simulation.jpg    # Simulation waveforms
├── T-Flip-Flop/
│   ├── src/
│   │   ├── T_flip_flop.v          # T Flip-Flop main module
│   │   └── (testbench in progress)
│   └── results/
│       ├── T_ff_schematic.jpg     # Schematic diagram
│       └── T_ff_synthesis.jpg     # Synthesis results
├── LICENSE                        # MIT License
└── README.md                      # This file
```

---

## 🛠️ D Flip-Flop Implementation

### Module: `D_flip_flop.v`

#### Architecture

The D flip-flop uses a clock divider circuit to scale down the input frequency by a factor of 25,000,000 (approximately converting 50 MHz to 2 Hz for visibility).

## 🛠️ T Flip-Flop Implementation

### Module: `T_flip_flop.v`

#### Architecture

The T flip-flop includes similar clock division logic for frequency scaling and implements toggle behavior.

#### Behavior Truth Table

| Clock Edge | Reset | T | Q (Next) | Description |
|-----------|-------|---|----------|-------------|
| ↑ | 1 | X | 0 | Asynchronous reset |
| ↑ | 0 | 1 | ~Q | Toggle output |
| ↑ | 0 | 0 | Q | Hold output |


### Resource Utilization (Typical)

**D Flip-Flop:**
- LUTs: ~8-12
- Registers: ~28 (27-bit counter + 1 output)
- Slices: ~2-4

**T Flip-Flop:**
- LUTs: ~12-16
- Registers: ~28 (27-bit counter + 1 output)
- Slices: ~3-5

## 🎓 Sequential Logic Concepts

### D Flip-Flop
- **Purpose**: Data storage synchronized with clock
- **Symbol**: ◇-shaped gate with D input
- **Application**: Sample-and-hold, data registers

### T Flip-Flop
- **Purpose**: Toggle counter operation
- **Symbol**: ◇-shaped gate with T input
- **Application**: Binary counters, frequency division

### Clock Divider
- **Purpose**: Reduce clock frequency
- **Method**: Counter-based modulo-N divider
- **Frequency Ratio**: 50 MHz → 2 Hz (1:25,000,000)


## 🔗 Related Concepts

- **Sequential Logic**: Circuits with memory and state
- **Flip-Flops**: Fundamental building blocks of digital systems
- **Clock Distribution**: Timing and synchronization in digital systems
- **Frequency Dividers**: Reducing clock rates for different timing domains
- **Verilog HDL**: Hardware description language for digital design
- **FPGA Implementation**: Mapping designs to programmable logic


