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

    // --- Input Aliases (directly matching your Verilog declarations) ---
    // These correspond to the ui_in pins as defined in your project.v
    wire Switch_0 = ui_in[0];
    wire Switch_1 = ui_in[1];
    wire Switch_2 = ui_in[2];
    wire Switch_3 = ui_in[3]; // Based on your 'project.v' original wire declarations
    wire Switch_4 = ui_in[4]; // Based on your 'project.v' original wire declarations
    wire Switch_5 = ui_in[5]; // Based on your 'project.v' original wire declarations

    // --- VGA and Color Signals ---
    wire hsync;
    wire vsync;
    reg  [1:0] R;
    reg  [1:0] G;
    reg  [1:0] B;
    wire video_active;
    wire [9:0] pix_x;
    wire [9:0] pix_y;

    // --- VGA Timing Generator ---
    hvsync_generator hvsync_gen (
        .clk(clk),
        .reset(~rst_n), // Invert active-low reset for the generator
        .hsync(hsync),
        .vsync(vsync),
        .display_on(video_active),
        .hpos(pix_x),
        .vpos(pix_y)
    );

    // --- Output Assignments ---
    assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;

    // --- Color Logic using Switch_X names ---
    // This logic directly uses the Switch_X names that you've declared.
    // It assumes the following mapping based on your *original code's comments*:
    // Switch_0 = armed (ui_in[0])
    // Switch_1 = door (ui_in[1])
    // Switch_2 = window (ui_in[2])
    // Switch_3 = reset_input (ui_in[3])
    // Switch_4 = motion (ui_in[4])
    // Switch_5 = temperature (ui_in[5])

    always @(*) begin
        // Default to black
        R = 2'b00;
        G = 2'b00;
        B = 2'b00;

        // Only update colors if display is active and not manually reset
        if (video_active && !Switch_3) begin // Assuming Switch_3 is your reset
            if (Switch_5) begin // Assuming Switch_5 is your temperature sensor
                R = 2'b11; G = 2'b11; B = 2'b11; // White (High Temp Warning)
            end else if (Switch_2) begin // Assuming Switch_2 is your window sensor
                R = 2'b11; G = 2'b11; B = 2'b00; // Yellow (Window Alarm)
            end else if (Switch_4 && Switch_1 && Switch_0) begin // Assuming Switch_4=motion, Switch_1=door, Switch_0=armed
                R = 2'b11; G = 2'b00; B = 2'b11; // Magenta (Armed Intrusion)
            end
            // If none of the above conditions met, it remains black (from default)
        end
    end

    // --- Unused Signal Tie-offs ---
    wire _unused_ok = ena;
    wire _unused_uio_in = uio_in[7:0];
    wire _unused_pix_x = pix_x;
    wire _unused_pix_y = pix_y;

endmodule
