FPGA Traffic Light Controller (VHDL)

*Overview

This project implements a traffic light control system on an FPGA using VHDL.
It demonstrates modular RTL design, finite state machines (FSMs), and hardware verification workflows.

The system was designed, simulated, and deployed on a Basys 3 (Artix-7 FPGA).

*Features:
- Modular VHDL architecture
- Finite State Machine (FSM) for traffic sequencing
- Clock prescaler for real-time timing control
- Input debouncing for stable signal handling
- Testbench-based verification
- On-board FPGA deployment and debugging

*System Architecture

The design is split into reusable modules:

- Clock Prescaler – Reduces FPGA clock to usable timing intervals
- Debouncer – Cleans asynchronous input signals
- Counter – Controls timing durations for each state
- FSM Controller – Governs traffic light transitions

*State Machine

The FSM controls the traffic light sequence:

- Green → Yellow → Red
- Deterministic timing ensures safe transitions
- Designed using synchronous logic principles

*Verification
- Developed VHDL testbenches to validate:
- Reset behaviour
- State transitions
- Timing correctness
- Used waveform analysis (Vivado) to debug:
- Logic errors
- Timing behaviour

*Hardware Implementation
- Target Board: Basys 3 (Artix-7 FPGA)
- Deployed design and verified behaviour on hardware
- Debugged using:
- LED outputs
- Timing observation
- Iterative refinement

*Key Learnings
Designing modular and reusable RTL components
Understanding synchronous digital design principles
Debugging using simulation + real hardware
Bridging theoretical design → physical implementation

*Future Improvements
- Add pedestrian crossing logic
- Introduce configurable timing parameters
- Extend to multi-intersection system
- Implement in SystemVerilog for advanced verification
