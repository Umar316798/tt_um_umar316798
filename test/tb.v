`default_nettype none

module tb;

  reg [2:0] ui_in;   // 3-bit input for motion, door, window
  wire uo_out;       // output: alarm

  // Instantiate your design
  tt_um_umar316798 uut (
    .ui_in(ui_in),
    .uo_out(uo_out)
  );

  initial begin
    $display("Time | motion door window | alarm");

    // Try all meaningful cases:
    ui_in = 3'b000; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b001; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b010; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b011; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b100; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b101; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b110; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);
    ui_in = 3'b111; #10 $display("%4t |   %b   %b   %b |   %b", $time, ui_in[0], ui_in[1], ui_in[2], uo_out);

    $finish;
  end

endmodule
