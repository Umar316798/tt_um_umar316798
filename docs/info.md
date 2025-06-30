<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
This project is a simple logic-based binary classifier that acts as a smart alarm trigger. 

It takes three binary inputs:
- `motion`: detects if motion is present 
- `door`: detects if a door is open
- `window`: detects if a window is open
- The logic uses simple combinational gates to decide whether to trigger the alarm.
- The output `alarm` will be `1` if either:
- Motion AND door are both active (`motion AND door`) 
- OR the window is open (`window`) Otherwise, the alarm output stays `0`.

## How to test
You can test the classifier by setting the three input bits (`motion`, `door`, `window`) to various combinations and observing the output `alarm`
To test locally, you can run a Verilog testbench that applies these input combinations and checks the output.


## External hardware

This project is purely logic-based and does not require any external hardware to function in simulation.

However, in a real-world smart alarm system, the inputs could come from:
- Motion sensor modules
- Door or window contact switches

The output `alarm` signal could drive:
- An LED
- A buzzer
- A relay to trigger an alarm siren
