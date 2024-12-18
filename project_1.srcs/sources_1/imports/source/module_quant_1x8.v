module module_quant_1x8
(
	input clk,
	
	input signed [15:0] scale,
    input [3:0] shift,
	input [7:0] zero_point,
	input quant_int_sel ,
	input signed [17:0] acc_result_0,
	input signed [17:0] acc_result_1,
	input signed [17:0] acc_result_2,
	input signed [17:0] acc_result_3,
	input signed [17:0] acc_result_4,
	input signed [17:0] acc_result_5,
	input signed [17:0] acc_result_6,
	input signed [17:0] acc_result_7,
	
//  output[3:0] quant_4result_0,
//	output[3:0] quant_4result_1,
//	output[3:0] quant_4result_2,
//	output[3:0] quant_4result_3,
//	output[3:0] quant_4result_4,
//	output[3:0] quant_4result_5,
//	output[3:0] quant_4result_6,
//	output[3:0] quant_4result_7,

	
	output [7:0] quant_result_0,
	output [7:0] quant_result_1,
	output [7:0] quant_result_2,
	output [7:0] quant_result_3,
	output [7:0] quant_result_4,
	output [7:0] quant_result_5,
	output [7:0] quant_result_6,
	output [7:0] quant_result_7
	
	
	
	
);

//assign  quant_4result_0 = quant_result_0[3:0];                                                   
//assign  quant_4result_1 = quant_result_1[3:0];                                                   
//assign  quant_4result_2 = quant_result_2[3:0];                                                   
//assign  quant_4result_3 = quant_result_3[3:0];                                                   
//assign  quant_4result_4 = quant_result_4[3:0];                                                   
//assign  quant_4result_5 = quant_result_5[3:0];                                                   
//assign  quant_4result_6 = quant_result_6[3:0];                                                   
//assign  quant_4result_7 = quant_result_7[3:0];                                                   



	module_quant u_module_quant_0
	(
		.clk(clk),
		.acc_result(acc_result_0),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_0)
	);
	module_quant u_module_quant_1
	(
		.clk(clk),
		.acc_result(acc_result_1),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_1)
	);
	module_quant u_module_quant_2
	(
		.clk(clk),
		.acc_result(acc_result_2),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_2)
	);
	module_quant u_module_quant_3
	(
		.clk(clk),
		.acc_result(acc_result_3),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_3)
	);
	module_quant u_module_quant_4
	(
		.clk(clk),
		.acc_result(acc_result_4),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_4)
	);
	module_quant u_module_quant_5
	(
		.clk(clk),
		.acc_result(acc_result_5),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_5)
	);
	module_quant u_module_quant_6
	(
		.clk(clk),
		.acc_result(acc_result_6),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_6)
	);
	module_quant u_module_quant_7
	(
		.clk(clk),
		.acc_result(acc_result_7),
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point),
		.quant_int_sel(quant_int_sel),
		.quant_result(quant_result_7)
	);

endmodule