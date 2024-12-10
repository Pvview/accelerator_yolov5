module cal_sub_zero_point
(
	input clk,
	input int_sel,
	input signed [7:0] zero_point,
	input signed [71:0] data_in,
	output reg signed [71:0] data_out
);


	always@(posedge clk) begin
		      data_out[7:0]<=data_in[7:0]-zero_point[7:0];
		      data_out[15:8]<=data_in[15:8]-zero_point[7:0];
		      data_out[23:16]<=data_in[23:16]-zero_point[7:0];
		      data_out[31:24]<=data_in[31:24]-zero_point[7:0];
		      data_out[39:32]<=data_in[39:32]-zero_point[7:0];
		      data_out[47:40]<=data_in[47:40]-zero_point[7:0];
		      data_out[55:48]<=data_in[55:48]-zero_point[7:0];
		      data_out[63:56]<=data_in[63:56]-zero_point[7:0];
		      data_out[71:64]<=data_in[71:64]-zero_point[7:0];
		      
		      
		      
		      
	end
endmodule