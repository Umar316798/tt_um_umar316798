`default_nettype none

module tb (
    // Inputs to the testbench, driven by cocotb
    input wire clk,
    input wire ena,
    input wire rst_n, // Active-low reset
    input wire [7:0] ui_in,
    input wire [7:0] uio_in,

    // Outputs from the testbench, monitored by cocotb
    output wire [7:0] uo_out,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    // Instantiate your design under test (DUT)
    tt_um_umar316798 user_project (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .ena(ena),
        .rst_n(rst_n)
    );

    // Initial block for VCD dumping (handled by cocotb's Makefile, but kept for completeness if needed elsewhere)
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
        #1; // Wait a little for setup
    end

endmodule

