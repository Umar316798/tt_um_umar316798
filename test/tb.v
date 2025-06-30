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

  // Instantiate your wrapped design under test (DUT)
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

  initial begin
    // Dummy values for unused inputs
    uio_in = 8'b0;
    clk = 1'b0;
    ena = 1'b1;
    rst_n = 1'b1;

    $display("Time | motion door window | alarm");

    // Stimulus: only using the low bits for your logic
    ui_in = 8'b00000000; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000001; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000010; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000011; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000100; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000101; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000110; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);
    ui_in = 8'b00000111; #10 $display("%4t | %b %b %b | %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out[0]);

    $finish;
  end

endmodule

