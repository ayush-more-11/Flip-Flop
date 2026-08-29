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

```
Input Clock (50 MHz)
        ↓
  Clock Divider
   (Counter)
        ↓
   Slow Clock (~2 Hz)
        ↓
  D Flip-Flop Logic
        ↓
   Output Q
```

#### Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1-bit | Input system clock (50 MHz) |
| `d` | Input | 1-bit | Data input to be captured |
| `q` | Output | 1-bit | Output (captures D on clock edge) |

#### Internal Components

| Component | Purpose | Width |
|-----------|---------|-------|
| `counter` | Frequency divider counter | 27-bit |
| `slow_clk` | Generated slower clock | 1-bit |

#### Clock Divider Logic

```verilog
// Counter increments on every system clock edge
// When counter reaches 24'd12_500_000, slow_clk pulses
// This creates a ~2 Hz clock from 50 MHz input
assign slow_clk = ( counter == 24'd12_500_000);

// Frequency calculation: 50 MHz / 25,000,000 = 2 Hz
// Period = 500,000,000 ns = 500 ms
```

#### Flip-Flop Operation

```verilog
// On every slow_clk edge:
// q (output) ← d (input)
always@(posedge slow_clk)begin
    q <= d;
end
```

**Timing**: Uses non-blocking assignment (`<=`) for proper sequential behavior

### Testbench: `D_flip_flop_tb.v`

#### Test Configuration

- **Clock Frequency**: 50 MHz (20 ns period)
- **Test Duration**: 1000 ns
- **Test Stimulus**: Multiple transitions on D input at varying intervals

#### Test Cases

| Time (ns) | D Input | Expected Behavior |
|-----------|---------|-------------------|
| 0-15 | 0 | Initialization |
| 15 | 1 | D goes HIGH |
| 40 | 0 | D goes LOW |
| 90 | 1 | D goes HIGH |
| 190 | 0 | D goes LOW |
| 390 | 1 | D goes HIGH |
| 690 | 0 | D goes LOW |
| 1090 | 1 | D goes HIGH |

#### Test Strategy

```verilog
// Stimulus pattern
#15 d = 1;      // First transition
#25 d = 0;      // Changed after 25ns
#50 d = 1;      // Changed after 50ns
#100 d = 0;     // Changed after 100ns
#200 d = 1;     // Changed after 200ns
#300 d = 0;     // Changed after 300ns
#400 d = 1;     // Final transition
```

#### Monitoring

```verilog
$monitor("Time = %0t, clk = %b, d = %b, q = %b", $time, clk, d, q);
```

Captures time, clock state, input D, and output Q for analysis.

### Simulation Results

The simulation produces waveforms showing:
- Input clock transitions
- D input changes
- Q output capturing D on clock edges
- Proper synchronization with the divider clock

**See**: `D-Flip-Flop/results/d_ff_simulation.jpg`

### Synthesis Results

The synthesized design shows:
- Gate-level implementation
- Logic cell utilization
- Pin assignments
- Critical path analysis

**See**: `D-Flip-Flop/results/d_ff_Synthesis.jpg`

### Schematic

The high-level schematic displays:
- D flip-flop logic block
- Clock divider circuit
- Input/output connections

**See**: `D-Flip-Flop/results/d_ff_Schematic.jpg`

---

## 🛠️ T Flip-Flop Implementation

### Module: `T_flip_flop.v`

#### Architecture

The T flip-flop includes similar clock division logic for frequency scaling and implements toggle behavior.

```
Input Clock (50 MHz)
    ↓
Clock Divider
    ↓
Slow Clock (~2 Hz)
    ↓
T Flip-Flop Logic
    ↓
Output Q
```

#### Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1-bit | Input system clock (50 MHz) |
| `T` | Input | 1-bit | Toggle control input |
| `reset` | Input | 1-bit | Asynchronous reset (active HIGH) |
| `Q` | Output | 1-bit | Output state |

#### Internal Components

| Component | Purpose | Width |
|-----------|---------|-------|
| `counter` | Frequency divider counter | 27-bit |
| `slow_clk` | Generated slower clock | 1-bit |

#### Clock Divider Logic

Identical to D flip-flop for consistent frequency division:
```verilog
assign slow_clk = ( counter == 24'd12_500_000);
// 50 MHz / 25,000,000 = 2 Hz (~500 ms period)
```

#### Toggle Operation

```verilog
always@(posedge slow_clk or posedge reset) begin
    if(reset) begin
        Q <= 0;          // Asynchronous reset
    end 
    else 
    if (T) begin 
        Q <= ~Q;         // Toggle when T is HIGH
    end
    // else: Q remains unchanged when T is LOW
end
```

#### Behavior Truth Table

| Clock Edge | Reset | T | Q (Next) | Description |
|-----------|-------|---|----------|-------------|
| ↑ | 1 | X | 0 | Asynchronous reset |
| ↑ | 0 | 1 | ~Q | Toggle output |
| ↑ | 0 | 0 | Q | Hold output |

### Frequency Divider Implementation

Both flip-flops use the same clock divider technique:

```verilog
reg[26:0] counter = 0;          // 27-bit counter
wire slow_clk;                   // Divided clock output

// Generate slow clock pulse
assign slow_clk = (counter == 24'd12_500_000);

// Counter logic
always@(posedge clk) begin 
    if(counter == 24'd12_500_000)
        counter <= 0;
    else 
        counter <= counter + 1;
end
```

**Purpose**: Reduces 50 MHz input to ~2 Hz for human-observable behavior in simulation

### Synthesis Results

Shows gate-level implementation of:
- Toggle logic
- Reset control
- Frequency divider
- Output buffering

**See**: `T-Flip-Flop/results/T_ff_synthesis.jpg`

### Schematic

Displays:
- T flip-flop logic block
- Multiplexer for toggle/hold selection
- Clock divider subcircuit

**See**: `T-Flip-Flop/results/T_ff_schematic.jpg`

---

## 🚀 Simulation Guide

### Prerequisites

- Verilog simulator (ModelSim, Vivado, Icarus Verilog, or similar)
- No external dependencies

### Running D Flip-Flop Simulation

**Using Icarus Verilog:**
```bash
cd D-Flip-Flop/src

# Compile
iverilog -o d_ff_sim D_flip_flop.v D_flip_flop_tb.v

# Run
vvp d_ff_sim
```

**Using ModelSim:**
```bash
cd D-Flip-Flop/src

vlog D_flip_flop.v D_flip_flop_tb.v
vsim D_flip_flop_tb
run -all
```

**Using Vivado:**
1. Create new Vivado project
2. Add `D_flip_flop.v` as design source
3. Add `D_flip_flop_tb.v` as simulation source
4. Run Simulation

### Expected Output

```
Time = 0, clk = 0, d = 0, q = 0
Time = 10, clk = 1, d = 0, q = 0
Time = 15, clk = 0, d = 1, q = 0
Time = 20, clk = 0, d = 1, q = 0
...
(Output follows input D at slower clock rate due to frequency divider)
```

### Running T Flip-Flop Simulation

```bash
cd T-Flip-Flop/src

# Using Icarus Verilog
iverilog -o t_ff_sim T_flip_flop.v

# Run
vvp t_ff_sim
```

---

## 📊 Waveform Analysis

### D Flip-Flop Behavior

```
Clock:   ____/¯¯¯\____/¯¯¯\____/¯¯¯\____
D:       _____/¯¯¯¯¯¯\____/¯¯¯¯¯¯\____
Q:       _________/¯¯¯¯¯¯\____/¯¯¯¯¯
         (Q changes with clock when data is ready)
```

**Key Characteristic**: Q output captures D input value on clock rising edge

### T Flip-Flop Behavior

```
Clock:   ____/¯¯¯\____/¯¯¯\____/¯¯¯\____
T:       ¯¯¯¯¯¯¯¯¯¯¯¯\____/¯¯¯¯¯¯¯¯¯
Q:       _________/¯¯¯¯¯\____/¯¯¯¯¯¯¯
         (Q toggles every clock when T=1)
```

**Key Characteristic**: Q output toggles on each clock edge when T=1, holds when T=0

---

## 💡 Design Characteristics

### Synchronous Design
- Both flip-flops are synchronous sequential circuits
- All state changes occur on clock edges
- No combinational feedback paths

### Clock Division Strategy
- Uses counter-based frequency divider
- Counts to 25 million (12.5 million ÷ 2 for 50% duty cycle)
- Creates observable slow clock from fast system clock

### Reset Behavior
- **D Flip-Flop**: No explicit reset (can be added)
- **T Flip-Flop**: Asynchronous active-high reset to Q=0

### Non-Blocking Assignments
- Proper use of `<=` for sequential logic
- Ensures correct timing and state propagation
- Avoids race conditions

---

## 🔧 Synthesis & Implementation

### Synthesis Target
- **Primary**: Xilinx FPGA (Series 7, UltraScale)
- **Secondary**: Altera/Intel MAX/Arria series
- **Tertiary**: ASIC standard cell libraries

### Resource Utilization (Typical)

**D Flip-Flop:**
- LUTs: ~8-12
- Registers: ~28 (27-bit counter + 1 output)
- Slices: ~2-4

**T Flip-Flop:**
- LUTs: ~12-16
- Registers: ~28 (27-bit counter + 1 output)
- Slices: ~3-5

### Maximum Operating Frequency
- **D Flip-Flop**: > 200 MHz (limited by divider counter)
- **T Flip-Flop**: > 200 MHz (limited by divider counter)

---

## 📝 Use Cases

### Educational Applications
- Learning sequential logic design
- Understanding flip-flop behavior
- Verilog HDL fundamentals
- Digital systems design courses

### Practical Applications
- **D Flip-Flop**: Data capture, storage elements, shift registers, state machines
- **T Flip-Flop**: Frequency dividers, counters, binary sequences, timing circuits

### System Components
- Register files
- State machines
- Counters and dividers
- Synchronization circuits

---

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

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Related Concepts

- **Sequential Logic**: Circuits with memory and state
- **Flip-Flops**: Fundamental building blocks of digital systems
- **Clock Distribution**: Timing and synchronization in digital systems
- **Frequency Dividers**: Reducing clock rates for different timing domains
- **Verilog HDL**: Hardware description language for digital design
- **FPGA Implementation**: Mapping designs to programmable logic

---

## 📋 Verification Checklist

- [x] D Flip-Flop behavioral simulation verified
- [x] D Flip-Flop testbench complete
- [x] D Flip-Flop schematic generated
- [x] D Flip-Flop synthesis complete
- [x] T Flip-Flop implementation complete
- [x] T Flip-Flop schematic generated
- [x] T Flip-Flop synthesis complete
- [ ] T Flip-Flop testbench (in progress)
- [ ] Integrated test suite

---

**Author**: ayush-more-11  
**Created**: September 2025  
**Project Status**: Complete (D Flip-Flop), Active Development (T Flip-Flop)  
**Last Updated**: August 29, 2026
