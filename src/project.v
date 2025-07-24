
`default_nettype none

module tt_um_umar316798 (
  input  wire [7:0] ui_in,    
  output wire [7:0] uo_out,   
  input  wire [7:0] uio_in,   
  output wire [7:0] uio_out,  
  output wire [7:0] uio_oe,   
  input  wire clk,            
  input  wire ena,           
  input  wire rst_n           
);

  wire armed       = ui_in[0];
  wire door        = ui_in[1];
  wire window      = ui_in[2];
  wire reset_input = ui_in[3]; 
  wire motion      = ui_in[4];
  wire temperature = ui_in[5];

  wire hsync;        // Horizontal sync signal from hvsync_generator
  wire vsync;        // Vertical sync signal from hvsync_generator
  reg [1:0] R;       // 2-bit Red color component (declared as reg for always block assignment)
  reg [1:0] G;       // 2-bit Green color component (declared as reg for always block assignment)
  reg [1:0] B;       // 2-bit Blue color component (declared as reg for always block assignment)
  wire video_active; // Indicates when the pixel is within the active display area
  wire [9:0] pix_x;  // Current horizontal pixel coordinate (0-639)
  wire [9:0] pix_y;  // Current vertical pixel coordinate (0-479)

  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(~rst_n),      // Global active-low reset is inverted for hvsync_generator
    .hsync(hsync),
    .vsync(vsync),
    .display_on(video_active),
    .hpos(pix_x),
    .vpos(pix_y)
  );

 
  wire _unused_pix_x = pix_x;
  wire _unused_pix_y = pix_y;

  assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};


  always @(*) begin
    R = 2'b00; G = 2'b00; B = 2'b00; // Default: Black

    if (video_active) begin // Only update colors if we are in the active display area
      if (reset_input) begin // Condition 1: Highest priority - Manual reset (ui_in[3])
        R = 2'b00; G = 2'b00; B = 2'b00; // Black (System enters idle/reset state)
      end else if (temperature) begin // Condition 2: High temperature warning (ui_in[5])
        R = 2'b11; G = 2'b11; B = 2'b11; // White (High Temp Warning)
      end else if (window) begin // Condition 3: Window open (ui_in[2])
        R = 2'b11; G = 2'b11; B = 2'b00; // Yellow (Alarm triggers due to window)
      end else if (motion && door && armed) begin // Condition 4: Motion AND Door AND Armed (ui_in[4], ui_in[1], ui_in[0])
        R = 2'b11; G = 2'b00; B = 2'b11; // Magenta (Alarm triggers due to motion/door while armed)
      end else begin
        
        R = 2'b00; G = 2'b00; B = 2'b00; 
      end
    end

  end

 
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000; 

  wire _unused_ok = ena; // 'ena' is always 1, so it's often unused directly.
  wire _unused_uio_in = uio_in; // 'uio_in' is not used in this design.

endmodule
