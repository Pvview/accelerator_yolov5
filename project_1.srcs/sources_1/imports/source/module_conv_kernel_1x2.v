module module_conv_kernel_1x2
(
	input clk,
	input int_sel,
	input [71:0] ifm_win3x3,
	input [71:0] weight_win3x3_ch1,
	input [71:0] weight_win3x3_ch2,
	output [17:0] ofm_stream_ch1,
	output [17:0] ofm_stream_ch2
);

//wire [71:0] ifm_48win3x3;      
//wire [71:0] weight_48win3x3_ch1;
//wire [71:0] weight_48win3x3_ch2;

//int4 to int8

//assign ifm_48win3x3[7:0]  =  (int_sel) ? {4'b0, ifm_win3x3[3:0] } :  ifm_win3x3[7:0]   ; assign ifm_48win3x3[31:24]  =  (int_sel) ? {4'b0, ifm_win3x3[15:12] } :  ifm_win3x3[31:24] ; assign ifm_48win3x3[55:48]  =  (int_sel) ? {4'b0, ifm_win3x3[27:24] } :  ifm_win3x3[55:48];   
//assign ifm_48win3x3[15:8] =  (int_sel) ? {4'b0, ifm_win3x3[7:4] } :  ifm_win3x3[15:8]  ; assign ifm_48win3x3[39:32]  =  (int_sel) ? {4'b0, ifm_win3x3[19:16] } :  ifm_win3x3[39:32] ; assign ifm_48win3x3[63:56]  =  (int_sel) ? {4'b0, ifm_win3x3[31:28] } :  ifm_win3x3[63:56];   
//assign ifm_48win3x3[23:16]=  (int_sel) ? {4'b0, ifm_win3x3[11:8]} :  ifm_win3x3[23:16] ; assign ifm_48win3x3[47:40]  =  (int_sel) ? {4'b0, ifm_win3x3[23:20]}  :  ifm_win3x3[47:40] ; assign ifm_48win3x3[71:64]  =  (int_sel) ? {4'b0, ifm_win3x3[35:32]}  :  ifm_win3x3[71:64];   

//assign weight_48win3x3_ch1[7:0]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[3:0] } :  weight_win3x3_ch1[7:0]   ; assign weight_48win3x3_ch1[31:24]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[15:12] } :  weight_win3x3_ch1[31:24] ; assign weight_48win3x3_ch1[55:48]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[27:24] } :  weight_win3x3_ch1[55:48];   
//assign weight_48win3x3_ch1[15:8] =  (int_sel) ? {4'b0, weight_win3x3_ch1[7:4] } :  weight_win3x3_ch1[15:8]  ; assign weight_48win3x3_ch1[39:32]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[19:16] } :  weight_win3x3_ch1[39:32] ; assign weight_48win3x3_ch1[63:56]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[31:28] } :  weight_win3x3_ch1[63:56];   
//assign weight_48win3x3_ch1[23:16]=  (int_sel) ? {4'b0, weight_win3x3_ch1[11:8]} :  weight_win3x3_ch1[23:16] ; assign weight_48win3x3_ch1[47:40]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[23:20]}  :  weight_win3x3_ch1[47:40] ; assign weight_48win3x3_ch1[71:64]  =  (int_sel) ? {4'b0, weight_win3x3_ch1[35:32]}  :  weight_win3x3_ch1[71:64];   

//assign weight_48win3x3_ch2[7:0]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[3:0] } :  weight_win3x3_ch2[7:0]   ; assign weight_48win3x3_ch2[31:24]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[15:12] } :  weight_win3x3_ch2[31:24] ; assign weight_48win3x3_ch2[55:48]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[27:24] } :  weight_win3x3_ch2[55:48];   
//assign weight_48win3x3_ch2[15:8] =  (int_sel) ? {4'b0, weight_win3x3_ch2[7:4] } :  weight_win3x3_ch2[15:8]  ; assign weight_48win3x3_ch2[39:32]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[19:16] } :  weight_win3x3_ch2[39:32] ; assign weight_48win3x3_ch2[63:56]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[31:28] } :  weight_win3x3_ch2[63:56];   
//assign weight_48win3x3_ch2[23:16]=  (int_sel) ? {4'b0, weight_win3x3_ch2[11:8]} :  weight_win3x3_ch2[23:16] ; assign weight_48win3x3_ch2[47:40]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[23:20]}  :  weight_win3x3_ch2[47:40] ; assign weight_48win3x3_ch2[71:64]  =  (int_sel) ? {4'b0, weight_win3x3_ch2[35:32]}  :  weight_win3x3_ch2[71:64]; 



	wire [7:0] win1_1;
	wire [7:0] win1_2;
	wire [7:0] win1_3;
	wire [7:0] win2_1;
	wire [7:0] win2_2;
	wire [7:0] win2_3;
	wire [7:0] win3_1;
	wire [7:0] win3_2;
	wire [7:0] win3_3;
	
	assign win1_1=ifm_win3x3[7:0];
	assign win1_2=ifm_win3x3[15:8];
	assign win1_3=ifm_win3x3[23:16];
	assign win2_1=ifm_win3x3[31:24];
	assign win2_2=ifm_win3x3[39:32];
	assign win2_3=ifm_win3x3[47:40];
	assign win3_1=ifm_win3x3[55:48];
	assign win3_2=ifm_win3x3[63:56];
	assign win3_3=ifm_win3x3[71:64];
	
	wire [7:0] weight_ch1_1_1;
	wire [7:0] weight_ch1_1_2;
	wire [7:0] weight_ch1_1_3;
	wire [7:0] weight_ch1_2_1;
	wire [7:0] weight_ch1_2_2;
	wire [7:0] weight_ch1_2_3;
	wire [7:0] weight_ch1_3_1;
	wire [7:0] weight_ch1_3_2;
	wire [7:0] weight_ch1_3_3;
	
	assign weight_ch1_1_1=weight_win3x3_ch1[7:0];
	assign weight_ch1_1_2=weight_win3x3_ch1[15:8];
	assign weight_ch1_1_3=weight_win3x3_ch1[23:16];
	assign weight_ch1_2_1=weight_win3x3_ch1[31:24];
	assign weight_ch1_2_2=weight_win3x3_ch1[39:32];
	assign weight_ch1_2_3=weight_win3x3_ch1[47:40];
	assign weight_ch1_3_1=weight_win3x3_ch1[55:48];
	assign weight_ch1_3_2=weight_win3x3_ch1[63:56];
	assign weight_ch1_3_3=weight_win3x3_ch1[71:64];
	
	wire [7:0] weight_ch2_1_1;
	wire [7:0] weight_ch2_1_2;
	wire [7:0] weight_ch2_1_3;
	wire [7:0] weight_ch2_2_1;
	wire [7:0] weight_ch2_2_2;
	wire [7:0] weight_ch2_2_3;
	wire [7:0] weight_ch2_3_1;
	wire [7:0] weight_ch2_3_2;
	wire [7:0] weight_ch2_3_3;
	
	assign weight_ch2_1_1=weight_win3x3_ch2[7:0];
	assign weight_ch2_1_2=weight_win3x3_ch2[15:8];
	assign weight_ch2_1_3=weight_win3x3_ch2[23:16];
	assign weight_ch2_2_1=weight_win3x3_ch2[31:24];
	assign weight_ch2_2_2=weight_win3x3_ch2[39:32];
	assign weight_ch2_2_3=weight_win3x3_ch2[47:40];
	assign weight_ch2_3_1=weight_win3x3_ch2[55:48];
	assign weight_ch2_3_2=weight_win3x3_ch2[63:56];
	assign weight_ch2_3_3=weight_win3x3_ch2[71:64];

	wire [15:0] ch1_out1_1;
	wire [15:0] ch1_out1_2;
	wire [15:0] ch1_out1_3;
	wire [15:0] ch1_out2_1;
	wire [15:0] ch1_out2_2;
	wire [15:0] ch1_out2_3;
	wire [15:0] ch1_out3_1;
	wire [15:0] ch1_out3_2;
	wire [15:0] ch1_out3_3;
	
	wire [15:0] ch2_out1_1;
	wire [15:0] ch2_out1_2;
	wire [15:0] ch2_out1_3;
	wire [15:0] ch2_out2_1;
	wire [15:0] ch2_out2_2;
	wire [15:0] ch2_out2_3;
	wire [15:0] ch2_out3_1;
	wire [15:0] ch2_out3_2;
	wire [15:0] ch2_out3_3;
	
	/* multiplier */
	cal_mult_int8_x2 u_cal_mult_int8_x2_1_1
	(
		.clk(clk),
		.a(weight_ch1_1_1),
		.b(weight_ch2_1_1),
		.c(win1_1),
		.int_sel(int_sel),
		.ac(ch1_out1_1),
		.bc(ch2_out1_1)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_1_2
	(
		.clk(clk),
		.a(weight_ch1_1_2),
		.b(weight_ch2_1_2),
		.c(win1_2),
	    .int_sel(int_sel),
		.ac(ch1_out1_2),
		.bc(ch2_out1_2)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_1_3
	(
		.clk(clk),
		.a(weight_ch1_1_3),
		.b(weight_ch2_1_3),
		.c(win1_3),
		.int_sel(int_sel),
		.ac(ch1_out1_3),
		.bc(ch2_out1_3)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_2_1
	(
		.clk(clk),
		.a(weight_ch1_2_1),
		.b(weight_ch2_2_1),
		.c(win2_1),
		.int_sel(int_sel),
		.ac(ch1_out2_1),
		.bc(ch2_out2_1)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_2_2
	(
		.clk(clk),
		.a(weight_ch1_2_2),
		.b(weight_ch2_2_2),
		.c(win2_2),
		.int_sel(int_sel),
		.ac(ch1_out2_2),
		.bc(ch2_out2_2)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_2_3
	(
		.clk(clk),
		.a(weight_ch1_2_3),
		.b(weight_ch2_2_3),
		.c(win2_3),
		.int_sel(int_sel),
		.ac(ch1_out2_3),
		.bc(ch2_out2_3)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_3_1
	(
		.clk(clk),
		.a(weight_ch1_3_1),
		.b(weight_ch2_3_1),
		.c(win3_1),
	    .int_sel(int_sel),
		.ac(ch1_out3_1),
		.bc(ch2_out3_1)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_3_2
	(
		.clk(clk),
		.a(weight_ch1_3_2),
		.b(weight_ch2_3_2),
		.c(win3_2),
	    .int_sel(int_sel),
		.ac(ch1_out3_2),
		.bc(ch2_out3_2)
	);
	cal_mult_int8_x2 u_cal_mult_int8_x2_3_3
	(
		.clk(clk),
		.a(weight_ch1_3_3),
		.b(weight_ch2_3_3),
		.c(win3_3),
		.int_sel(int_sel),
		.ac(ch1_out3_3),
		.bc(ch2_out3_3)
	);
	/* adder tree */
	cal_addtree_int16_x9 u_cal_addtree_int16_x9_1
	(
		.clk(clk),
		.int_sel(int_sel),
		.a1(ch1_out1_1),
		.a2(ch1_out1_2),
		.a3(ch1_out1_3),
		.a4(ch1_out2_1),
		.a5(ch1_out2_2),
		.a6(ch1_out2_3),
		.a7(ch1_out3_1),
		.a8(ch1_out3_2),
		.a9(ch1_out3_3),
		.dout(ofm_stream_ch1)
	);
	cal_addtree_int16_x9 u_cal_addtree_int16_x9_2
	(
		.clk(clk),
		.int_sel(int_sel),
		.a1(ch2_out1_1),
		.a2(ch2_out1_2),
		.a3(ch2_out1_3),
		.a4(ch2_out2_1),
		.a5(ch2_out2_2),
		.a6(ch2_out2_3),
		.a7(ch2_out3_1),
		.a8(ch2_out3_2),
		.a9(ch2_out3_3),
		.dout(ofm_stream_ch2)
	);

endmodule