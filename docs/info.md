<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->
# Tiny Logic-Based Inference Classifier
## How it works
This project implements a simple logic-based binary classifier that acts as a smart alarm system with visual feedback. 

It processes inputs from six digital switches: 

•	Switch_0: Corresponds to the "armed" state, indicating if the system is active. 

•	Switch_1: Corresponds to a "door" sensor, detecting if a door is open. 

•	Switch_2: Corresponds to a "window" sensor, detecting if a window is open. 

•	Switch_3: Corresponds to a "reset" signal, for manually resetting the system to an idle state. 

•	Switch_4: Corresponds to a "motion" sensor, detecting presence. 

•	Switch_5: Corresponds to a "temperature" sensor, indicating a high-temperature warning.

The system's status is then output as a color to a VGA display.



## How to test
You can run the Verilog testbench to apply different input combinations. 
Example test cases: 

## How to test
You can run the Verilog testbench (e.g., using Cocotb) to apply different combinations to the ui_in pins (represented by Switch_0 through Switch_5) and observe the VGA output colors.
Example test cases:

•	Switch_4 = 1 (Motion), Switch_1 = 1 (Door), and Switch_0 = 1 (Armed): The alarm triggers, and the VGA output will be Magenta.

•	Switch_2 = 1 (Window): An alarm triggers due to an open window, resulting in a Yellow VGA output.

•	All Switches = 0: The system is idle, and there is no alarm, resulting in a Black VGA output.

•	Switch_5 = 1 (Temperature): A high-temperature warning is issued, showing a White VGA output.

•	Switch_3 = 1 (Reset): The system enters an idle/reset state, displaying a Black VGA output (overriding other alarms).

## External hardware

No external hardware is required, but in a real-world use case, the following could be connected: 

• motion sensor 

• door/window 

• switches 

• temperature sensor 

• system control buttons (armed/reset)

• VGA monitor to show output colors
