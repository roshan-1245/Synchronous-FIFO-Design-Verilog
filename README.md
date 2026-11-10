# 16×8 Synchronous FIFO Design Using Verilog HDL

## Project Overview

This project presents the RTL design and functional verification of a 16-depth, 8-bit synchronous FIFO (First-In First-Out) using Verilog HDL.

The FIFO is implemented using a shift-register-based memory architecture, where input data is stored sequentially and retrieved in the same order in which it was written.

The design includes FIFO status monitoring, programmable threshold detection, and error detection mechanisms. Functional verification is performed using a dedicated testbench in Xilinx Vivado Simulator.

## Key Features

- 16 × 8-bit FIFO memory (128-bit total storage capacity).
- Synchronous push and pop operations.
- FIFO Full and Empty flag generation.
- Overrun detection for write attempts when FIFO is full.
- Underrun detection for read attempts when FIFO is empty.
- Programmable threshold detection.
- Simultaneous push and pop support.
- Asynchronous active-high reset.
- Internal FIFO memory monitoring.
- Behavioral simulation using Xilinx Vivado.

## Design Specifications

| Parameter | Specification |
|---|---|
| FIFO Architecture | Synchronous FIFO |
| FIFO Depth | 16 |
| Data Width | 8 bits |
| Total Storage | 128 bits |
| Clock | Single Clock |
| Reset | Asynchronous Active-High |
| Memory Architecture | Shift Register |
| HDL | Verilog / SystemVerilog |
| Simulation Tool | Xilinx Vivado |
| Verification | Behavioral Simulation |

## Input and Output Signals

| Signal | Direction | Description |
|---|---|---|
| clk | Input | Clock signal |
| rst | Input | Asynchronous reset |
| en | Input | FIFO enable |
| push_in | Input | Write request |
| pop_in | Input | Read request |
| din[7:0] | Input | 8-bit input data |
| dout[7:0] | Output | 8-bit output data |
| empty | Output | Indicates FIFO is empty |
| full | Output | Indicates FIFO is full |
| overrun | Output | Indicates write attempt on full FIFO |
| underrun | Output | Indicates read attempt on empty FIFO |
| threshold[3:0] | Input | Programmable occupancy threshold |
| thre_trigger | Output | Threshold detection indicator |

## Project Directory Structure

```text
Synchronous-FIFO-Design-Verilog/
│
├── RTL/
│   └── fifo_top.sv
│
├── Testbench/
│   └── fifo_tb.sv
│
├── Simulation/
│   ├── fifo_write_operation.png
│   ├── fifo_read_operation.png
│   ├── fifo_overrun_detection.png
│   ├── fifo_underrun_detection.png
│   └── fifo_memory_update.png
│
├── RTL_Schematic/
│   └── fifo_rtl_schematic.png
│
└── README.md
```

## RTL Design Description

The FIFO design consists of the following functional blocks:

### 1. FIFO Memory

A 16-location memory array is used to store 8-bit data. Data is written sequentially and shifted towards the output during valid read operations.

### 2. Push Operation

When `en` and `push_in` are asserted and the FIFO is not full, incoming data is stored in the FIFO memory.

### 3. Pop Operation

When `en` and `pop_in` are asserted and the FIFO is not empty, the first stored data element is retrieved from the output.

### 4. Full and Empty Detection

- `full = 1`: Indicates all 16 FIFO locations are occupied.
- `empty = 1`: Indicates that no valid data is available.

### 5. Overrun and Underrun Detection

- Overrun: Detects an invalid write request when the FIFO is full.
- Underrun: Detects an invalid read request when the FIFO is empty.

### 6. Programmable Threshold Detection

The threshold input specifies the FIFO occupancy level at which the threshold trigger is asserted.

## Testbench and Functional Verification

A Verilog testbench (`fifo_tb.sv`) is developed to verify the functionality of the FIFO design.

The testbench generates a clock, applies reset, provides input data, and performs push and pop operations.

### Test Scenarios

| Test Case | Description |
|---|---|
| Reset | Initializes FIFO memory and status flags |
| Write | Writes sequential data into FIFO |
| Read | Reads stored data in FIFO order |
| Full Detection | Checks FIFO full condition |
| Empty Detection | Checks FIFO empty condition |
| Overrun | Tests writing into a full FIFO |
| Underrun | Tests reading from an empty FIFO |
| Threshold | Checks programmable threshold trigger |

## Simulation Results and Waveform Analysis

Functional verification is performed using Xilinx Vivado Simulator.

The following waveforms demonstrate the FIFO operations and status flag behavior.

### 1. FIFO Write Operation

Demonstrates sequential data insertion into FIFO memory. The input data is stored in the memory array while the write request is enabled.
<img width="1627" height="847" alt="Screenshot 2026-11-10 231052" src="https://github.com/user-attachments/assets/44628146-649c-4639-b6d7-c28a071b3404" />


### 2. FIFO Full and Overrun Detection

Demonstrates the FIFO full condition after storing 16 data elements. An additional write request activates the overrun indicator.

<img width="1607" height="847" alt="Screenshot 2026-11-10 232304" src="https://github.com/user-attachments/assets/fc026dcd-a96a-42bd-ac1d-e184c76ed0c3" />


### 3. FIFO Read Operation

Demonstrates sequential data retrieval from FIFO memory. The output data follows the First-In First-Out principle.

<img width="1610" height="858" alt="Screenshot 2026-11-10 231010" src="https://github.com/user-attachments/assets/31f82fd4-c523-4f37-9333-ed1432f50e01" />


### 4. FIFO Empty and Underrun Detection

Demonstrates the empty condition after reading all stored data. An additional read request activates the underrun indicator.
<img width="1607" height="847" alt="Screenshot 2026-11-10 232304" src="https://github.com/user-attachments/assets/f88e2bd9-3982-40a1-8da8-030633b7b91e" />)

### 5. Internal FIFO Memory Update

The waveform illustrates the internal memory array during FIFO read and write operations, including data shifting and memory updates.

<img width="1583" height="831" alt="Screenshot 2026-11-10 230952" src="https://github.com/user-attachments/assets/6c0e5eee-5ac4-4dab-8221-88d9790d3fbc" />


## Synthesized RTL Schematic

The RTL schematic generated using Xilinx Vivado illustrates the synthesized logic structure and interconnections of the FIFO design.

<img width="1591" height="823" alt="Screenshot 2026-11-10 230341" src="https://github.com/user-attachments/assets/c09cb8f6-37f3-4007-86bb-03c1dfba10e8" />


## Simulation Summary

The behavioral simulation demonstrates the following functionalities:

- Correct sequential data storage and retrieval.
- FIFO full and empty status indication.
- Overrun and underrun error detection.
- Programmable threshold triggering.
- Internal memory shifting.
- FIFO data ordering.

## Tools and Technologies

- Verilog HDL / SystemVerilog
- Xilinx Vivado
- RTL Design
- Behavioral Simulation
- Digital Logic Design
- Functional Verification

## References and Learning Resources

**Reference Course:**

- Course: Communication Series Part 1 – UART, SPI and I2C in Verilog
- Platform: Udemy
- Reference Lecture: [Communication Series – Verilog](https://www.udemy.com/course/communication-series-p1-uart-spi-and-i2c-in-verilog/learn/lecture/40249308#overview)

This course was used as a learning reference for understanding Verilog-based digital design and RTL implementation concepts.

## Learning Outcomes

- Understanding FIFO architecture and memory organization.
- Designing sequential digital circuits using Verilog HDL.
- Implementing FIFO control and status logic.
- Developing functional verification testbenches.
- Analyzing simulation waveforms using Vivado.
- Understanding RTL synthesis and schematic generation.
- Debugging RTL design and simulation issues.


---

**Keywords:** FIFO Design | Verilog HDL | SystemVerilog | RTL Design | RTL Verification | Digital Design | Xilinx Vivado | FPGA Design | Functional Verification
