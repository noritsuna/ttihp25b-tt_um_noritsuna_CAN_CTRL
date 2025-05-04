`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECE398 CAN Controller Design
// 
// Create Date:    23:00 05/08/2025
// Module Name:    CAN_CONTROLLER
// Project Name:   CAN_Controller
// Description: Implements the CAN Bus protocol.
//////////////////////////////////////////////////////////////////////////////////
module CAN_CONTROLLER(
	output CAN_TX,
	output TXING,
	input CAN_RX,
	input RESET,
	input CLOCK_SIGNAL_IN,
	input send_data,
	input [3:0] CAN_ADDR,
	input [3:0] transmit_data,
	input [3:0] transmit_data_counter
	);

	wire[10:0] address;
	
	reg[63:0] tx_data;
	reg[15:0] tx_cnt;
	initial tx_cnt = 0;
	wire baud_clk;

	//Device address
	assign address = {7'b0, CAN_ADDR};
	
	//Baud Clk Generator(currently set for baud of 500kHz)
	BaudGen baud_calc(CLOCK_SIGNAL_IN,RESET,baud_clk);
	
	//Tx Block
	tx_container tx_can(CAN_TX,TXING,CAN_RX,address,CLOCK_SIGNAL_IN,baud_clk,RESET,tx_data,send_data);

	always @ (posedge CLOCK_SIGNAL_IN or posedge RESET) begin
		if(RESET) begin
			tx_data <= 0;
			tx_cnt  <= 0;
		end
		else if(!send_data) begin
			case(transmit_data_counter)
				4'b0000: tx_data[3:0]   <= transmit_data;
				4'b0001: tx_data[7:4]   <= transmit_data;
				4'b0010: tx_data[11:8]  <= transmit_data;
				4'b0011: tx_data[15:12] <= transmit_data;
				4'b0100: tx_data[19:16] <= transmit_data;
				4'b0101: tx_data[23:20] <= transmit_data;
				4'b0110: tx_data[27:24] <= transmit_data;
				4'b0111: tx_data[31:28] <= transmit_data;
				4'b1000: tx_data[35:32] <= transmit_data;
				4'b1001: tx_data[39:36] <= transmit_data;
				4'b1010: tx_data[43:40] <= transmit_data;
				4'b1011: tx_data[47:44] <= transmit_data;
				4'b1100: tx_data[51:48] <= transmit_data;
				4'b1101: tx_data[55:52] <= transmit_data;
				4'b1110: tx_data[59:56] <= transmit_data;
				4'b1111: tx_data[63:60] <= transmit_data;
				default: tx_data[3:0]   <= transmit_data;
				endcase
		end
		else if(send_data) begin
			if(!TXING && tx_cnt > 64*40) begin
				tx_data <= 0;
			end
			tx_cnt <= tx_cnt + 1;
		end
	end
endmodule
