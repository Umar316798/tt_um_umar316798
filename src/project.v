/*
 * Tiny Logic-Based Inference Classifier with VGA Output
 * Author: Umar
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// hvsync_generator module: Generates VGA horizontal and vertical sync signals,
// pixel coordinates, and a display_on signal based on 640x480 VGA timing.
module hvsync_generator (
  input wire clk,         // Clock input
  input wire reset,       // Asynchronous reset (active high)
  output reg hsync,       // Horizontal sync output
  output reg vsync,       // Vertical sync output
  output reg display_on,  // High when video pixel is active (inside display area)
  output reg [9:0] hpos,  // Current horizontal pixel position (0-639)
  output reg [9:0] vpos   // Current vertical pixel position (0-479)
);

  // VGA Timing Constants for 640x480 @ 60Hz
  // Horizontal (pixels)
  localparam H_DISPLAY  = 640; // Visible pixels
  localparam H_FPORCH   = 16;  // Front porch
  localparam H_SYNC     = 96;  // Sync pulse width
  localparam H_BPORCH   = 48;  // Back porch
  localparam H_TOTAL    = H_DISPLAY + H_FPORCH + H_SYNC + H_BPORCH; // Total pixels per line (800)

  // Vertical (lines)
  localparam V_DISPLAY  = 480; // Visible lines
  localparam V_FPORCH   = 10;  // Front porch
  localparam V_SYNC     = 2;   // Sync pulse width
  localparam V_BPORCH   = 33;  // Back porch
  localparam V_TOTAL    = V_DISPLAY + V_FPORCH + V_SYNC + V_BPORCH; // Total lines per frame (525)

  // Horizontal counter
  reg [9:0] h_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      h_count <= 0;
      hsync <= 1; // Active low sync, so default to high
      hpos <= 0;
    end else begin
      if (h_count == H_TOTAL - 1) begin
        h_count <= 0;
      end else begin
        h_count <= h_count + 1;
      end

      // Generate HSYNC pulse
      if (h_count >= H_DISPLAY + H_FPORCH && h_count < H_DISPLAY + H_FPORCH + H_SYNC) begin
        hsync <= 0; // HSYNC active low
      end else begin
        hsync <= 1;
      end

      // Calculate horizontal position for display
      if (h_count < H_DISPLAY) begin
        hpos <= h_count;
      end else begin
        hpos <= 0; // Reset hpos outside display area
      end
    end
  end

  // Vertical counter
  reg [9:0] v_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      v_count <= 0;
      vsync <= 1; // Active low sync, so default to high
      vpos <= 0;
    end else begin
      if (h_count == H_TOTAL - 1) begin // Increment vertical counter at end of horizontal line
        if (v_count == V_TOTAL - 1) begin
          v_count <= 0;
        end else begin
          v_count <= v_count + 1;
        end
      end

      // Generate VSYNC pulse
      if (v_count >= V_DISPLAY + V_FPORCH && v_count < V_DISPLAY + V_FPORCH + V_SYNC) begin
        vsync <= 0; // VSYNC active low
      end else begin
        vsync <= 1;
      end

      // Calculate vertical position for display
      if (v_count < V_DISPLAY) begin
        vpos <= v_count;
      end else begin
        vpos <= 0; // Reset vpos outside display area
      end
    end
  end

  // Determine if the current pixel is within the active display area
  always @(*) begin
    if (h_count < H_DISPLAY && v_count < V_DISPLAY) begin
      display_on = 1;
    end else begin
      display_on = 0;
    end
  end

endmodule


// Top-level module for the Tiny Logic-Based Inference Classifier
module tt_um_umar316798 (
  input  wire [7:0] ui_in,    // standard 8-bit user inputs
  output wire [7:0] uo_out,   // standard 8-bit user outputs
  input  wire [7:0] uio_in,   // bidirectional IO in
  output wire [7:0] uio_out,  // bidirectional IO out
  output wire [7:0] uio_oe,   // bidirectional IO output enable
  input  wire clk,            // clock
  input  wire ena,            // enable (always 1 when the design is powered)
  input  wire rst_n           // reset_n (active low reset)
);

  // --- Input Mapping (based on info.yml) ---
  wire armed       = ui_in[0];
  wire door        = ui_in[1];
  wire window      = ui_in[2];
  wire reset_input = ui_in[3]; // Renamed to avoid conflict with rst_n
  wire motion      = ui_in[4];
  wire temperature = ui_in[5];

  // --- Internal VGA Signals ---
  wire hsync;
  wire vsync;
  wire [1:0] R; // 2-bit Red
  wire [1:0] G; // 2-bit Green
  wire [1:0] B; // 2-bit Blue
  wire video_active;
  wire [9:0] pix_x; // Current pixel X coordinate
  wire [9:0] pix_y; // Current pixel Y coordinate

  // --- Instantiate the HVSync Generator ---
  // The reset input to hvsync_generator is active high, so we invert rst_n.
  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(~rst_n), // Use the global active-low reset
    .hsync(hsync),
    .vsync(vsync),
    .display_on(video_active),
    .hpos(pix_x),
    .vpos(pix_y)
  );

  // --- VGA Output Assignment (matches Tiny Tapeout PMOD) ---
  // uo_out[7:0] = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]}
  // This maps the 2-bit RGB and sync signals to the 8-bit output bus.
  assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  // --- Smart Alarm Logic to Determine Display Color ---
  // This logic determines the background color for the entire screen.
  // Priority: Reset > Temperature Warning > Alarm States > Idle
  always @(*) begin
    if (reset_input) begin // Highest priority: Manual reset
      R = 2'b00; G = 2'b00; B = 2'b00; // Black (Idle/Reset State)
    end else if (temperature) begin // High temperature warning
      R = 2'b11; G = 2'b11; B = 2'b11; // White (High Temp Warning)
    end else if (video_active) begin // Only apply color if video is active
      if ((motion && door && armed)) begin // Intrusion: Motion AND Door AND Armed
        R = 2'b11; G = 2'b00; B = 2'b11; // Magenta (Alarm Trigger)
      end else if (window) begin // Intrusion: Window open
        R = 2'b11; G = 2'b11; B = 2'b00; // Yellow (Alarm Trigger)
      end else begin
        R = 2'b00; G = 2'b00; B = 2'b00; // Black (No Alarm / Idle)
      end
    end else begin // When video is not active (during blanking periods)
      R = 2'b00; G = 2'b00; B = 2'b00; // Black to ensure stable blanking
    end
  end

  // --- Tie off unused IO pins and suppress warnings ---
  assign uio_out = 0;
  assign uio_oe  = 0;
  wire _unused_ok = &{ena, uio_in}; // ui_in is used for alarm inputs

endmodule
