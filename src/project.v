/*
 * Tiny Logic-Based Inference Classifier
 * Author: Umar
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_umar316798 (
  input  wire [7:0] ui_in,    // standard 8-bit user inputs
  output wire [7:0] uo_out,   // standard 8-bit user outputs
  input  wire [7:0] uio_in,   // bidirectional IO in
  output wire [7:0] uio_out,  // bidirectional IO out
  output wire [7:0] uio_oe,   // bidirectional IO output enable
  input  wire clk,            // clock (not used)
  input  wire ena,            // enable (not used)
  input  wire rst_n           // reset_n (not used)
);

  // Smart alarm logic: (motion AND door) OR window
  assign uo_out[0] = (ui_in[0] & ui_in[1]) | ui_in[2];

  // Tie off unused output bits so they don't float
  assign uo_out[7:1] = 0;

  // Tie off unused IO pins
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Bundle unused inputs so the synthesizer won't complain
  wire _unused = &{ uio_in, clk, ena, rst_n };

endmodule
