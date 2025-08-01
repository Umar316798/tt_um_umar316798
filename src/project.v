/*
 * Copyright (c) 2024 Uri Shaked
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_umar316798 (
  input  wire [7:0] ui_in,
  output wire [7:0] uo_out,
  input  wire [7:0] uio_in,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe,
  input  wire       ena,
  input  wire       clk,
  input  wire       rst_n
);

  wire armed_input    = ui_in[0];
  wire door_sensor    = ui_in[1];
  wire window_sensor  = ui_in[2];
  wire manual_reset   = ui_in[3];
  wire motion_sensor  = ui_in[4];

  wire hsync;
  wire vsync;
  reg  [1:0] R;
  reg  [1:0] G;
  reg  [1:0] B;
  wire video_active;
  wire [9:0] pix_x;
  wire [9:0] pix_y;

  reg alarm_active;
  reg [23:0] flash_counter;
  reg flash_toggle;

  assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  assign uio_out = 0;
  assign uio_oe   = 0;

  wire _unused_ok = &{ena, uio_in[7:0], pix_x, pix_y};


  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(~rst_n),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(video_active),
    .hpos(pix_x),
    .vpos(pix_y)
  );
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      alarm_active <= 1'b0;
      flash_counter <= 24'b0;
      flash_toggle <= 1'b0;
      R <= 2'b00;
      G <= 2'b00;
      B <= 2'b00;
    end else if (ena) begin
      if (manual_reset) begin
        alarm_active <= 1'b0;
      end else if (armed_input) begin
        if (door_sensor || window_sensor || motion_sensor) begin
          alarm_active <= 1'b1;
        end
      end else begin
        alarm_active <= 1'b0;
      end

      flash_counter <= flash_counter + 1;
      if (flash_counter == 24'h7FFFFF) begin
        flash_toggle <= ~flash_toggle;
        flash_counter <= 24'b0;
      end

      if (video_active) begin
        if (!armed_input) begin
          R <= 2'b00; G <= 2'b00; B <= 2'b11;
        end else if (alarm_active) begin
          if (flash_toggle) begin
            R <= 2'b11; G <= 2'b00; B <= 2'b00;
          end else begin
            R <= 2'b00; G <= 2'b00; B <= 2'b00;
          end
        end else begin
          R <= 2'b00; G <= 2'b11; B <= 2'b00;
        end
      end else begin
        R <= 2'b00; G <= 2'b00; B <= 2'b00;
      end
    end
  end
  
endmodule