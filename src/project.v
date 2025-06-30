/*
 * Tiny Logic-Based Inference Classifier
 * Author: Umar
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_umar316798 (
    input  wire [2:0] ui_in,   // 3 dedicated input bits: motion, door, window
    output wire       uo_out   // 1 dedicated output bit: alarm
);

  // Smart alarm logic:
  assign uo_out = (ui_in[0] & ui_in[1]) | ui_in[2];

endmodule
