`define default_netname none
`default_nettype none
/*
 * tt_um_noritsuna_CAN_CTRL.v
 *
 * tt_um_noritsuna_CAN_CTRL module
 *
 * Author: Noritsuna Imamura <noritsuna@ishi-kai.org>
 */

module tt_um_noritsuna_CAN_CTRL (
	input  wire [7:0] ui_in,	// Dedicated inputs
	output wire [7:0] uo_out,	// Dedicated outputs
	input  wire [7:0] uio_in,	// IOs: Input path
	output wire [7:0] uio_out,	// IOs: Output path
	output wire [7:0] uio_oe,	// IOs: Enable path (active high: 0=input, 1=output)
	input  wire       ena,
	input  wire       clk,
	input  wire       rst_n
);

	// All output pins must be assigned. If not used, assign to 0.
	assign uio_out[7:0] = 0;
	assign uo_out[7:5] = 0;

	// IOs: Enable path (active high: 0=input, 1=output)
	assign uio_oe[3:0] = 0;
	assign uio_oe[7:4] = 0;

	// TT pins
	assign uo_out[2] = ena;
	assign uo_out[3] = clk;
	assign uo_out[4] = rst_n;

	CAN_CONTROLLER can_ctrl(
		.CAN_TX(uo_out[0]),
		.TXING(uo_out[1]),
		.CAN_RX(ui_in[0]),
		.RESET_N(ui_in[3]),
		.CLOCK_SIGNAL_IN(ui_in[2]),
		.send_data(ui_in[1]),

		.CAN_ADDR(ui_in[7:4]),
		.transmit_data(uio_in[3:0]),
		.transmit_data_counter(uio_in[7:4])
		);


endmodule // tt_um_noritsuna_CAN_CTRL