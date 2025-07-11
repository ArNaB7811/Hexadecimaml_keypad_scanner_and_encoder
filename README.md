# Hex Keypad Scanner and Encoder – Verilog Project
This project implements a hexadecimal keypad scanner and encoder using Verilog. It consists of three primary modules:

`1` hex_keypad.v – The finite state machine (FSM) that scans columns and detects key presses.

`2` Row_signal.v – Generates the row signal based on the pressed key and active column.

`3` synchronizer.v – Synchronizes the asynchronous row inputs for reliable FSM operation.

The testbench simulates key presses and validates the operation of the keypad scanner by monitoring:

* Detected key codes

* Valid signal assertion

* Row/column activity

## Files Included
`1` hex_keypad.v – Contains the hex_keypad FSM module.

`2` Row_signal.v – Contains the Row_signal module.
`3` synchronizer.v - Contains the synchronizer module.

`4` testbench_hex_keypad.v – Simulates various keypress combinations and logs waveform data.

## Features
* 4x4 Keypad Support – Detects keys 0–F using row-column scanning.

* FSM-based Scanning – Cycles through columns and checks row activity.

* Debounce Synchronization – Handles row glitches using two-stage sync.

* Keycode Encoding – Outputs a 4-bit code corresponding to the pressed key.

* Test Automation – Testbench cycles through all keys with realistic timing.
## Note
* The design assumes only one key is pressed at a time.
## Output 
* 
