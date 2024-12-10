module module_sub_zero_point_1x8
(
	input clk,
	input signed [7:0] zero_point,
//	input signed [3:0] zero_4point,

	input int_sel      ,
	input cov_sel    ,
	
	input [71:0] data_in_0,
	input [71:0] data_in_1,
	input [71:0] data_in_2,
	input [71:0] data_in_3,
	input [71:0] data_in_4,
	input [71:0] data_in_5,
	input [71:0] data_in_6,
	input [71:0] data_in_7,
	
//	input [3:0] data_4in_0,
//	input [3:0] data_4in_1,
//	input [3:0] data_4in_2,
//	input [3:0] data_4in_3,
//	input [3:0] data_4in_4,
//	input [3:0] data_4in_5,
//	input [3:0] data_4in_6,
//	input [3:0] data_4in_7,

//	output [3:0] data_4out_0,    
//	output [3:0] data_4out_1,    
//	output [3:0] data_4out_2,    
//	output [3:0] data_4out_3,    
//	output [3:0] data_4out_4,    
//	output [3:0] data_4out_5,    
//	output [3:0] data_4out_6,    
//	output [3:0] data_4out_7,     



	
	output [71:0] data_out_0,
	output [71:0] data_out_1,
	output [71:0] data_out_2,
	output [71:0] data_out_3,
	output [71:0] data_out_4,
	output [71:0] data_out_5,
	output [71:0] data_out_6,
	output [71:0] data_out_7
);
/*wire [7:0] data_48in_0;
wire [7:0] data_48in_1;
wire [7:0] data_48in_2;
wire [7:0] data_48in_3;
wire [7:0] data_48in_4;
wire [7:0] data_48in_5;
wire [7:0] data_48in_6;
wire [7:0] data_48in_7;*/

//assign data_48in_0  = (int_sel)   ?  data_4in_0   :   data_in_0    ;
//assign data_48in_1  = (int_sel)   ?  data_4in_1   :   data_in_1    ;
//assign data_48in_2  = (int_sel)   ?  data_4in_2   :   data_in_2    ;
//assign data_48in_3  = (int_sel)   ?  data_4in_3   :   data_in_3    ;
//assign data_48in_4  = (int_sel)   ?  data_4in_4   :   data_in_4    ;
//assign data_48in_5  = (int_sel)   ?  data_4in_5   :   data_in_5    ;
//assign data_48in_6  = (int_sel)   ?  data_4in_6   :   data_in_6    ;
//assign data_48in_7  = (int_sel)   ?  data_4in_7   :   data_in_7    ;


//assign   data_4out_0 =    data_out_0 [3:0]   ;
//assign   data_4out_1 =    data_out_1 [3:0]   ;
//assign   data_4out_2 =    data_out_2 [3:0]   ;
//assign   data_4out_3 =    data_out_3 [3:0]   ;
//assign   data_4out_4 =    data_out_4 [3:0]   ;
//assign   data_4out_5 =    data_out_5 [3:0]   ;
//assign   data_4out_6 =    data_out_6 [3:0]   ;
//assign   data_4out_7 =    data_out_7 [3:0]   ;


//wire [7:0] zero_48point ;

//assign zero_48point  = (int_sel) ? zero_4point : zero_point ;


	cal_sub_zero_point u_cal_sub_zero_point_0
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_0),
		.data_out(data_out_0)
	);
	cal_sub_zero_point u_cal_sub_zero_point_1
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_1),
		.data_out(data_out_1)
	);
	cal_sub_zero_point u_cal_sub_zero_point_2
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_2),
		.data_out(data_out_2)
	);
	cal_sub_zero_point u_cal_sub_zero_point_3
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_3),
		.data_out(data_out_3)
	);
	cal_sub_zero_point u_cal_sub_zero_point_4
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_4),
		.data_out(data_out_4)
	);
	cal_sub_zero_point u_cal_sub_zero_point_5
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_5),
		.data_out(data_out_5)
	);
	cal_sub_zero_point u_cal_sub_zero_point_6
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_6),
		.data_out(data_out_6)
	);
	cal_sub_zero_point u_cal_sub_zero_point_7
	(
		.clk(clk),
		.int_sel(int_sel),
		.zero_point(zero_point),
		.data_in(data_in_7),
		.data_out(data_out_7)
	);


endmodule