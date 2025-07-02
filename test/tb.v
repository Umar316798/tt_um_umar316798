`default_nettype none

module tb;

  // Inputs
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  reg clk;
  reg ena;
  reg rst_n;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // DUT
  tt_um_umar316798 uut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .clk(clk),
    .ena(ena),
    .rst_n(rst_n)
  );

endmodule

