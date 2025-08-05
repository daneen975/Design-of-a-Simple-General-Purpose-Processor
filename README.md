COE 328 - General-Purpose Processor Design in VHDL

This project showcases the design and simulation of a simple General-Purpose Processor (GPP) implemented in VHDL for an Intel FPGA platform (via Quartus II). The processor includes a full datapath and control architecture including:

- A custom Arithmetic Logic Unit (ALU) capable of both arithmetic and bitwise logic operations.
- A modular control unit using a Finite State Machine (FSM) and decoder.
- Synchronous registers for operand storage.
- A simulation pipeline and testbench using waveform-driven verification.

System Architecture Overview:

The design follows a classic 4-part processing pipeline:

1. Register File (Storage Units)
- Two 8-bit input registers (A and B), loaded on the clock's rising edge
-Inputs initialized from student ID digits during simulation
- Synchronously store and forward data to the ALU core

2. Control Unit
- Composed of:
  - FSM: Cycles through 9 states (or more, depending on extensions), each corresponding to a specific ALU function
  - 4-to-16 Decoder: Converts FSM state into a 16-bit microcode signal for the ALU

3. ALU Core
 - Accepts 8-bit A and B inputs, and a 16-bit operation selector (OP) from the Control Unit
 - Supports 9 operations by default: sum, difference, bitwise AND, OR, XOR, etc.
 - Output: 8-bit Result rendered in waveform simulation and via 7-segment hex display

4. Display Unit
- Outputs ALU result on dual 7-segment displays
- Also includes a third display for the FSM state or student ID output

Features & Functionality:

Initial Processor Design
- Cycles through 9 operations using FSM-controlled microcode.
- Displays each result sequentially based on clock-driven FSM transitions.

Modular VHDL Architecture
- All components (Register, ALU, FSM, Decoder) are built as reusable modules using structural VHDL.
- Symbol creation and schematic integration completed in Quartus II using `.bdf`.

Modified ALU Extension (Problem 2)
- Supports alternate instruction sets assigned dynamically (e.g., rotate, shift, max/min, custom logic).
- ALU adapted to perform logic such as:
  - `SHR`, `SHL`, `ROR`, `ROL`, bit inversion, parity checking, 2s complement, conditional XOR/XNOR.
- Demonstrates flexibility and extensibility of the core design.

FSM-Driven Conditional Display (Problem 3)
- FSM output conditionally drives the 7-segment display to show 'Y' or 'N' based on logic such as:
  - Parity (even/odd) of state
  - A/B comparison with FSM value
  - Equality or relational logic
- Integrates logic comparisons between register content and FSM-driven microcode.


