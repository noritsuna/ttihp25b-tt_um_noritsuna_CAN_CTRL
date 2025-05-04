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

	wire _unused = &{ena, clk, ui_in[3], uo_out[2], uo_out[3], uo_out[4], uo_out[5], uo_out[6], uo_out[7], 1'b0};

	CAN_CONTROLLER can_ctrl(
		.CAN_TX(uo_out[0]),
		.TXING(uo_out[1]),
		.CAN_RX(ui_in[0]),
		.RESET(rst_n),
		.CLOCK_SIGNAL_IN(ui_in[2]),
		.send_data(ui_in[1]),

		.CAN_ADDR(ui_in[7:4]),
		.transmit_data(uio_in[3:0]),
		.transmit_data_counter(uio_in[7:4])
		);


endmodule // tt_um_noritsuna_CAN_CTRL