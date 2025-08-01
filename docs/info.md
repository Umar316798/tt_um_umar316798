<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->
# Tiny Logic-Based Inference Classifier

## Project Overview

This project implements a **logic-based inference classifier** designed as a smart home security system. It processes digital inputs from various sensors to determine the system's state and provides immediate visual feedback via a **VGA display** using a clear color-coded interface.

## How It Works

The system operates based on the state of several digital inputs, which emulate a home security setup:

* **`Armed_Input` (ui[0]):** A digital switch that determines if the security system is active.
    * **HIGH (1):** System is Armed.
    * **LOW (0):** System is Disarmed.
* **`Door_Sensor` (ui[1]):** A digital magnetic contact sensor that detects the state of a door.
    * **HIGH (1):** Door is open.
    * **LOW (0):** Door is closed.
* **`Window_Sensor` (ui[2]):** A digital magnetic contact sensor that detects the state of a window.
    * **HIGH (1):** Window is open.
    * **LOW (0):** Window is closed.
* **`Manual_Reset` (ui[3]):** A momentary digital pushbutton to reset the alarm state.
    * **HIGH (1):** Resets the triggered alarm.
    * **LOW (0):** Normal operation.
* **`Motion_Sensor` (ui[4]):** A digital Passive Infrared (PIR) sensor that detects movement.
    * **HIGH (1):** Motion detected.
    * **LOW (0):** No motion.
* **`ui_in[5]` - `ui_in[7]`:** These pins are currently **unused** in this design.

### System States and VGA Output Colors:

The system displays its status using a dedicated VGA color scheme:

* **Disarmed State:**
    * **Condition:** `Armed_Input` is **LOW**.
    * **VGA Color:** **BLUE**
    * **Description:** The security system is inactive. Sensor inputs will not trigger an alarm.
* **Armed & Secure State:**
    * **Condition:** `Armed_Input` is **HIGH**, AND `Door_Sensor`, `Window_Sensor`, and `Motion_Sensor` are **all LOW**.
    * **VGA Color:** **GREEN**
    * **Description:** The security system is active, and all monitored points (doors, windows, motion) are secure.
* **Alarm Triggered State:**
    * **Condition:** `Armed_Input` is **HIGH**, AND any of `Door_Sensor`, `Window_Sensor`, or `Motion_Sensor` goes **HIGH**. This state persists once triggered.
    * **VGA Color:** **FLASHING RED** (alternating between Red and Black)
    * **Description:** An intrusion or breach has been detected while the system was armed. The screen will flash red until the `Manual_Reset` button is pressed.

## Hardware Implementation

While the core logic runs on the TinyTapeout chip, real-world operation requires external digital hardware.

* **TinyTapeout Demo Board:** This board houses your custom ASIC (chip) and provides PMOD connections for I/O.
* **Breadboard:** Necessary to expand the power (VCC) and ground (GND) connections available from the TinyTapeout board's PMOD.
* **Digital Sensors:**
    * **PIR Motion Sensor:** Connects to `Motion_Sensor` (ui[4]).
    * **Magnetic Contact Sensors:** For `Door_Sensor` (ui[1]) and `Window_Sensor` (ui[2]).
    * **Pushbuttons/Switches:** For `Armed_Input` (ui[0]) and `Manual_Reset` (ui[3]).
* **Jumper Wires:** Used to connect the sensors to the breadboard's power/ground rails and then route the sensor output signals to the appropriate `ui_in` pins on the TinyTapeout PMOD.
* **VGA Monitor:** Connects to the `uo_out` pins to display the system's status colors.

## How to Test

You can run the Verilog testbench (e.g., using Cocotb or your simulation environment) to apply different digital input combinations to the `ui_in` pins and observe the resulting VGA output colors.

### Example Test Cases:

* **Scenario 1: System Disarmed**
    * `Armed_Input` = **0** (LOW)
    * `Door_Sensor` = X (don't care)
    * `Window_Sensor` = X
    * `Motion_Sensor` = X
    * `Manual_Reset` = X
    * **Expected VGA Output:** **BLUE**

* **Scenario 2: System Armed and Secure**
    * `Armed_Input` = **1** (HIGH)
    * `Door_Sensor` = **0** (LOW)
    * `Window_Sensor` = **0** (LOW)
    * `Motion_Sensor` = **0** (LOW)
    * `Manual_Reset` = **0** (LOW)
    * **Expected VGA Output:** **GREEN**

* **Scenario 3: Alarm Triggered (Door Open while Armed)**
    * `Armed_Input` = **1** (HIGH)
    * `Door_Sensor` = **1** (HIGH)
    * `Window_Sensor` = **0** (LOW)
    * `Motion_Sensor` = **0** (LOW)
    * `Manual_Reset` = **0** (LOW)
    * **Expected VGA Output:** **FLASHING RED** (will remain flashing until reset or disarmed)

* **Scenario 4: Resetting the Alarm**
    * *After Scenario 3, with alarm still flashing red...*
    * `Armed_Input` = **1** (HIGH)
    * `Door_Sensor` = **0** (LOW) *(Assume door is now closed)*
    * `Window_Sensor` = **0** (LOW)
    * `Motion_Sensor` = **0** (LOW)
    * `Manual_Reset` = **1** (HIGH) *(Momentarily set high, then back to 0)*
    * **Expected VGA Output:** Transitions from FLASHING RED to **GREEN** (Armed & Secure) once `Manual_Reset` is released and all sensors are clear.
