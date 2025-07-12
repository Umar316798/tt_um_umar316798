<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
This project is a simple logic-based binary classifier that acts as a smart alarm trigger.

It takes six binary inputs: 

•	armed – system is armed and ready
•	reset – manually resets the system 
•	motion – detects if motion is present 
•	door – detects if a door is open 
•	window – detects if a window is open 
•	temperature – detects high temperature

## How to test
You can run the Verilog testbench to apply different input combinations. 
Example test cases: 
motion = 1, door = 1, armed = 1 → alarm triggers (Magenta) 
window = 1 → alarm triggers (Yellow) 
all inputs = 0 → no alarm (Black) 
temperature = 1 → high temp warning (White) 
reset = 1 → system enters idle/reset state (Black) 
The VGA output color will change based on the current state to help visualize the system status.


## External hardware

No external hardware is required, but in a real-world use case, the following could be connected: 
motion sensor 
door/window 
switches 
temperature sensor 
system control buttons (armed/reset)
VGA monitor to show output colors
