<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->
# Tiny Logic-Based Inference Classifier

## Project Overview

This project implements a logic-based inference classifier for a home security system. It uses digital inputs from various sensors to determine the system's state and displays immediate, color-coded visual feedback on a VGA monitor.

The system's core logic is designed for compatibility with common digital sensors and switches, providing a platform to test their integration with an ASIC.

## Digital Inputs (ui[0]-ui[4])

The following digital inputs drive the system's logic, emulating a home security setup:

ui[0] (Armed_Input): A toggle switch (e.g., Mini Toggle Switch) to arm/disarm the system. (1 = Armed, 0 = Disarmed).

ui[1] (Door_Sensor): A magnetic contact sensor (e.g., MC-38 Reed Switch) to detect door status. (1 = Open, 0 = Closed).

ui[2] (Window_Sensor): A magnetic contact sensor (e.g., MC-38 Reed Switch) to detect window status. (1 = Open, 0 = Closed).

ui[3] (Manual_Reset): A momentary pushbutton (e.g., 12mm Tactile Pushbutton) to reset a triggered alarm.

ui[4] (Motion_Sensor): A PIR motion sensor (e.g., HC-SR501) to detect movement. (1 = Motion, 0 = No Motion).

## System States and VGA Output
The system's status is communicated visually through a VGA color output:

BLUE: Disarmed. The system is inactive.

GREEN: Armed & Secure. All monitored points are closed/still.

FLASHING RED: Alarm Triggered. A sensor has been activated while the system was armed. The alarm persists until a manual reset.

## Hardware Requirements
The final project requires the following components to operate with the TinyTapeout chip:

Digital Sensors:

HC-SR501 PIR Motion Sensor (for Motion_Sensor)

MC-38 Magnetic Reed Switch (for Door_Sensor and Window_Sensor)

Control Inputs:

Mini Toggle Switch (for Armed_Input)

12mm Momentary Tactile Pushbutton (for Manual_Reset)

Display:

A VGA-compatible monitor connected to the uo_out pins.

## How to Test
Simulation testbenches can be used to verify the logic. Key scenarios include:

Disarmed: Armed_Input = 0 always results in BLUE.

Armed & Secure: Armed_Input = 1 with all other sensors 0 results in GREEN.

Alarm Triggered: Armed_Input = 1 and any sensor goes 1 results in FLASHING RED.

Alarm Reset: A HIGH signal on Manual_Reset will clear a triggered alarm, returning the system to the GREEN state (provided all sensors are clear).
