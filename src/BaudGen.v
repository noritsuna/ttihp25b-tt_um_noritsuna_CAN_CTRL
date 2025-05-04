`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Rose-Hulman Institute of Technology
// Tom D'Agostino
// ECE398 CAN Controller Design
// 
// Create Date:    21:29:50 03/13/2015 
// Module Name:    BaudGen
// Project Name:   Serial
// Description: Generates the required baud rate for communication.
//////////////////////////////////////////////////////////////////////////////////
module BaudGen(clk,rst,baud_clk);
input clk,rst;
output reg baud_clk;

//EndCount is equal to clk frequency/baud frequency
// Therefore 20MHz/500kHz = 40
parameter EndCount = 10'd40;
reg[9:0] count = 0;

always@(posedge clk)begin
	if(rst == 1) begin
		count <=10'd0;
		baud_clk <= 0;
	end
	else if(count == EndCount) begin
		count <= 10'd0; 
		baud_clk <= ~baud_clk;
		end
	else begin
		count <= count + 10'd1;
		baud_clk <= baud_clk;
		end
	end

endmodule
