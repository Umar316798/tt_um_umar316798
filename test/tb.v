`default_nettype none

module tb ();

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  reg [7:0] ui_in;

  wire [7:0] uo_out;

  tt_um_umar316798 user_project (
    .ui_in(ui_in),
    .uo_out(uo_out)
  );

  reg clk = 0;
  parameter CLK_HALF_PERIOD = 5;
  always #CLK_HALF_PERIOD clk = ~clk;

  initial begin
    ui_in = 8'b00000000; 
    # (CLK_HALF_PERIOD * 2);


    // Test 1: Reset / Idle
    @(posedge clk) begin
      ui_in = 8'b00001000; // reset high
      $display("Time %0t: Test 1: Reset / Idle (Expected Black)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 2: Armed only
    @(posedge clk) begin
      ui_in = 8'b00000001; // armed
      $display("Time %0t: Test 2: Armed (Expected Red)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 3: Door Open
    @(posedge clk) begin
      ui_in = 8'b00000010; // door
      $display("Time %0t: Test 3: Door Open (Expected Yellow)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 4: Motion Detected
    @(posedge clk) begin
      ui_in = 8'b00010000; // motion
      $display("Time %0t: Test 4: Motion Detected (Expected Blue)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 5: High Temperature
    @(posedge clk) begin
      ui_in = 8'b00100000; // temperature
      $display("Time %0t: Test 5: High Temp (Expected White)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 6: Threat Detected (armed + motion)
    @(posedge clk) begin
      ui_in = 8'b00010001; // motion + armed
      $display("Time %0t: Test 6: Threat Detected (Expected Magenta)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 7: Armed & Safe 
    @(posedge clk) begin
      ui_in = 8'b00000001; 
      $display("Time %0t: Test 7: System Safe (Expected Green)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    // Test 8: Invalid / Unknown State (all inputs high)
    @(posedge clk) begin
      ui_in = 8'b11111111;
      $display("Time %0t: Test 8: Unknown/Error (Expected Purple)", $time);
    end
    # (CLK_HALF_PERIOD * 100000);

    $display("Time %0t: Simulation complete.", $time);
    $finish;
  end

endmodule


