module linebuffer_3x3_collect
#(
	parameter LEN1=16,
	parameter LEN2=14,
	parameter LEN3=28,
	parameter LEN4=56,
	parameter LEN5=112,
	parameter LEN6=224
)
(
	input clk,
	input [2:0] sel ,
	input    cov_sel,
//	input    int_sel,
	//int8
	input [71:0] ifmstream_0,
	input [71:0] ifmstream_1,
	input [71:0] ifmstream_2,
	input [71:0] ifmstream_3,
	input [71:0] ifmstream_4,
	input [71:0] ifmstream_5,
	input [71:0] ifmstream_6,
	input [71:0] ifmstream_7,
//	//int4
//	input [3:0] ifmstream4_0,
//	input [3:0] ifmstream4_1,
//	input [3:0] ifmstream4_2,
//	input [3:0] ifmstream4_3,
//	input [3:0] ifmstream4_4,
//	input [3:0] ifmstream4_5,
//	input [3:0] ifmstream4_6,
//	input [3:0] ifmstream4_7,

    //int8
	output [71:0] ifm_win3x3_0,
	output [71:0] ifm_win3x3_1,
	output [71:0] ifm_win3x3_2,
	output [71:0] ifm_win3x3_3,
	output [71:0] ifm_win3x3_4,
	output [71:0] ifm_win3x3_5,
	output [71:0] ifm_win3x3_6,
	output [71:0] ifm_win3x3_7
	
//	  //int4                  
//	output [35:0] ifm_4win3x3_0,
//	output [35:0] ifm_4win3x3_1,
//	output [35:0] ifm_4win3x3_2,
//	output [35:0] ifm_4win3x3_3,
//	output [35:0] ifm_4win3x3_4,
//	output [35:0] ifm_4win3x3_5,
//	output [35:0] ifm_4win3x3_6,
//	output [35:0] ifm_4win3x3_7

	
);

//wire [7:0] ifmstream48_0  ;
//wire [7:0] ifmstream48_1  ;
//wire [7:0] ifmstream48_2  ;
//wire [7:0] ifmstream48_3  ;
//wire [7:0] ifmstream48_4  ;
//wire [7:0] ifmstream48_5  ;
//wire [7:0] ifmstream48_6  ;
//wire [7:0] ifmstream48_7  ;

assign ifm_win3x3_0  =   (cov_sel)  ?    ifm_win3x3_00 : ifmstream_0 ;
assign ifm_win3x3_1  =   (cov_sel)  ?    ifm_win3x3_11 : ifmstream_1 ;
assign ifm_win3x3_2  =   (cov_sel)  ?    ifm_win3x3_22 : ifmstream_2 ;
assign ifm_win3x3_3  =   (cov_sel)  ?    ifm_win3x3_33 : ifmstream_3 ;
assign ifm_win3x3_4  =   (cov_sel)  ?    ifm_win3x3_44 : ifmstream_4 ;
assign ifm_win3x3_5  =   (cov_sel)  ?    ifm_win3x3_55 : ifmstream_5 ;
assign ifm_win3x3_6  =   (cov_sel)  ?    ifm_win3x3_66 : ifmstream_6 ;
assign ifm_win3x3_7  =   (cov_sel)  ?    ifm_win3x3_77 : ifmstream_7 ;

//assign ifm_4win3x3_0  =  {ifm_win3x3_0 [67:64] ,ifm_win3x3_0 [59:56] ,ifm_win3x3_0 [51:48] ,ifm_win3x3_0 [43:40] ,ifm_win3x3_0 [35:32]  ,ifm_win3x3_0 [27:24] ,ifm_win3x3_0 [19:16] ,ifm_win3x3_0 [11:8] ,ifm_win3x3_0 [3:0]}    ;
//assign ifm_4win3x3_1  =  {ifm_win3x3_1 [67:64] ,ifm_win3x3_1 [59:56] ,ifm_win3x3_1 [51:48] ,ifm_win3x3_1 [43:40] ,ifm_win3x3_1 [35:32]  ,ifm_win3x3_1 [27:24] ,ifm_win3x3_1 [19:16] ,ifm_win3x3_1 [11:8] ,ifm_win3x3_1 [3:0]}    ;
//assign ifm_4win3x3_2  =  {ifm_win3x3_2 [67:64] ,ifm_win3x3_2 [59:56] ,ifm_win3x3_2 [51:48] ,ifm_win3x3_2 [43:40] ,ifm_win3x3_2 [35:32]  ,ifm_win3x3_2 [27:24] ,ifm_win3x3_2 [19:16] ,ifm_win3x3_2 [11:8] ,ifm_win3x3_2 [3:0]}    ;
//assign ifm_4win3x3_3  =  {ifm_win3x3_3 [67:64] ,ifm_win3x3_3 [59:56] ,ifm_win3x3_3 [51:48] ,ifm_win3x3_3 [43:40] ,ifm_win3x3_3 [35:32]  ,ifm_win3x3_3 [27:24] ,ifm_win3x3_3 [19:16] ,ifm_win3x3_3 [11:8] ,ifm_win3x3_3 [3:0]}    ;
//assign ifm_4win3x3_4  =  {ifm_win3x3_4 [67:64] ,ifm_win3x3_4 [59:56] ,ifm_win3x3_4 [51:48] ,ifm_win3x3_4 [43:40] ,ifm_win3x3_4 [35:32]  ,ifm_win3x3_4 [27:24] ,ifm_win3x3_4 [19:16] ,ifm_win3x3_4 [11:8] ,ifm_win3x3_4 [3:0]}    ;
//assign ifm_4win3x3_5  =  {ifm_win3x3_5 [67:64] ,ifm_win3x3_5 [59:56] ,ifm_win3x3_5 [51:48] ,ifm_win3x3_5 [43:40] ,ifm_win3x3_5 [35:32]  ,ifm_win3x3_5 [27:24] ,ifm_win3x3_5 [19:16] ,ifm_win3x3_5 [11:8] ,ifm_win3x3_5 [3:0]}    ;
//assign ifm_4win3x3_6  =  {ifm_win3x3_6 [67:64] ,ifm_win3x3_6 [59:56] ,ifm_win3x3_6 [51:48] ,ifm_win3x3_6 [43:40] ,ifm_win3x3_6 [35:32]  ,ifm_win3x3_6 [27:24] ,ifm_win3x3_6 [19:16] ,ifm_win3x3_6 [11:8] ,ifm_win3x3_6 [3:0]}    ;
//assign ifm_4win3x3_7  =  {ifm_win3x3_7 [67:64] ,ifm_win3x3_7 [59:56] ,ifm_win3x3_7 [51:48] ,ifm_win3x3_7 [43:40] ,ifm_win3x3_7 [35:32]  ,ifm_win3x3_7 [27:24] ,ifm_win3x3_7 [19:16] ,ifm_win3x3_7 [11:8] ,ifm_win3x3_7 [3:0]}    ;

wire [71:0]ifm_win3x3_00  ;
wire [71:0]ifm_win3x3_11  ;
wire [71:0]ifm_win3x3_22  ;
wire [71:0]ifm_win3x3_33  ;
wire [71:0]ifm_win3x3_44  ;
wire [71:0]ifm_win3x3_55  ;
wire [71:0]ifm_win3x3_66  ;
wire [71:0]ifm_win3x3_77  ;



	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_0
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_0),
		.ifm_win3x3_batch(ifm_win3x3_00)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_1
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_1),
		.ifm_win3x3_batch(ifm_win3x3_11)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_2
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_2),
		.ifm_win3x3_batch(ifm_win3x3_22)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_3
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_3),
		.ifm_win3x3_batch(ifm_win3x3_33)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_4
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_4),
		.ifm_win3x3_batch(ifm_win3x3_44)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_5
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_5),
		.ifm_win3x3_batch(ifm_win3x3_55)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_6
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_6),
		.ifm_win3x3_batch(ifm_win3x3_66)
	);
	linebuffer_3x3_type_x6
	#(
		.LEN1(LEN1),
		.LEN2(LEN2),
		.LEN3(LEN3),
		.LEN4(LEN4),
		.LEN5(LEN5),
		.LEN6(LEN6)
	)
	u_linebuffer_3x3_type_x6_7
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
		.ifmstream_in(ifmstream_7),
		.ifm_win3x3_batch(ifm_win3x3_77)
	);
endmodule