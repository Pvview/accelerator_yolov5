module accel_top
#(
	parameter IFMBUF_ADDR_BIT=12,
	parameter WEIGHTBUF_ADDR_BIT=7,
	parameter BIASBUF_ADDR_BIT=7,
	parameter BATCHBUF_ADDR_BIT =9,
	parameter ACC_ADDR_BIT=12,
	parameter OFMBUF_ADDR_BIT=12,
	
	parameter IFMBUF_DEPTH=4096*2,
	parameter WEIGHTBUF_DEPTH=128,
	parameter BIASBUF_DEPTH=128,
	parameter ACC_DEPTH=4096,
	parameter OFMBUF_DEPTH=4096,
	
	parameter LINEBUFFER_LEN1=16,
	parameter LINEBUFFER_LEN2=14,
	parameter LINEBUFFER_LEN3=28,
	parameter LINEBUFFER_LEN4=56,
	parameter LINEBUFFER_LEN5=112,
	parameter LINEBUFFER_LEN6=224,
	
	parameter IFM_RAM_STYLE="block",
	parameter WEIGHT_RAM_STYLE="distributed",
	parameter BIAS_RAM_STYLE="distributed",
	parameter OFM_RAM_STYLE="block"
)
(
	input clk,
	input rst,
	input int_sel,
	input cov_sel,
	input quant_int_sel,
	input [2:0] sel,
	input relu_type_sel,
	input pool_enable,
//	input data_vaild ,
	
	////////////////////////////////////////
//	input batch_enable,
	
	//////////////////////////////
	input [IFMBUF_ADDR_BIT-1:0] ifmbuf_bram_addr_write,
	input [IFMBUF_ADDR_BIT-1:0] ifmbuf_bram_addr_read,
	input ifmbuf_bram_en_write,
	input ifmbuf_sel,
	
	input weightbuf_waddr_clear,
	input weightbuf_bram_en_write,
	////////////////////////////////////
//	input batchbuf_waddr_clear,
//	input batchbuf_bram_en_write,
//	input [BATCHBUF_ADDR_BIT-1:0] batchbuf_read_addr,
	
	input [WEIGHTBUF_ADDR_BIT-1:0] weightbuf_read_addr,
	///////////////////////////////////////////////////
	input biasbuf_waddr_clear,
	input biasbuf_bram_en_write,
	input [BIASBUF_ADDR_BIT-1:0] biasbuf_read_addr,

	 
	input acc_read_en,
	input acc_write_en,
	input [ACC_ADDR_BIT-1:0] acc_read_addr,
	input [ACC_ADDR_BIT-1:0] acc_write_addr,
	input acc_prev_data_zero,
	input acc_curr_data_zero,
	
	input pool_zero_out,
	
	input ofmbuf_bram_en_write,
	input [OFMBUF_ADDR_BIT-1:0] ofmbuf_bram_write_addr,
	input [OFMBUF_ADDR_BIT-1:0] ofmbuf_bram_read_addr,
	
	input	[15:0]	scale,
    input	[3:0]	shift,
	input	[7:0]	zero_point_in,
	
	input	[7:0]	zero_point_out,
	input	[7:0]	zero_point_act,
	
	input	[7:0]	ifm_in_0,
	input	[7:0]	ifm_in_1,
	input	[7:0]	ifm_in_2,
	input	[7:0]	ifm_in_3,
	input	[7:0]	ifm_in_4,
	input	[7:0]	ifm_in_5,
	input	[7:0]	ifm_in_6,
	input	[7:0]	ifm_in_7,
	
	
//	//int4
//    input [3:0]      in4_0 ,
//    input [3:0]      in4_1 ,
//    input [3:0]      in4_2 ,
//    input [3:0]      in4_3 ,
//    input [3:0]      in4_4 ,
//    input [3:0]      in4_5 ,
//    input [3:0]      in4_6 ,
//    input [3:0]      in4_7 ,
	

	
	
	input	[7:0]	weight_in_0,
	input	[7:0]	weight_in_1,
	input	[7:0]	weight_in_2,
	input	[7:0]	weight_in_3,
	input	[7:0]	weight_in_4,
	input	[7:0]	weight_in_5,
	input	[7:0]	weight_in_6,
	input	[7:0]	weight_in_7,

//    input	[3:0]	weight_4in_0, 
//    input	[3:0]	weight_4in_1, 
//    input	[3:0]	weight_4in_2, 
//    input	[3:0]	weight_4in_3, 
//    input	[3:0]	weight_4in_4, 
//    input	[3:0]	weight_4in_5, 
//    input	[3:0]	weight_4in_6, 
//    input	[3:0]	weight_4in_7, 

//    input   [7:0]   batch_norm_in0,
//    input   [7:0]   batch_norm_in1,
//    input   [7:0]   batch_norm_in2,
//    input   [7:0]   batch_norm_in3,
//    input   [7:0]   batch_norm_in4,
//    input   [7:0]   batch_norm_in5,
//    input   [7:0]   batch_norm_in6,
//    input   [7:0]   batch_norm_in7,
    
//    input   [3:0]   batch_4norm_in0,
//    input   [3:0]   batch_4norm_in1,
//    input   [3:0]   batch_4norm_in2,
//    input   [3:0]   batch_4norm_in3,
//    input   [3:0]   batch_4norm_in4,
//    input   [3:0]   batch_4norm_in5,
//    input   [3:0]   batch_4norm_in6,
//    input   [3:0]   batch_4norm_in7,
    
    



	input	[15:0]	write_addr_leakyrelu,
	input	[63:0]	write_data_leakyrelu,
	input			write_enable_leakyrelu,
	
	input [17:0] bias_in,
	
//	input [8:0] bias4_in,
	
	input bias_valid,
	
    output [63:0] ofm_out_bundle  ,
    output [31:0] ofm_out4_bundle   

	
	
	

	
);

	wire	[71:0]	ifmstream_0;
	wire	[71:0]	ifmstream_1;
	wire	[71:0]	ifmstream_2;
	wire	[71:0]	ifmstream_3;
	wire	[71:0]	ifmstream_4;
	wire	[71:0]	ifmstream_5;
	wire	[71:0]	ifmstream_6;
	wire	[71:0]	ifmstream_7;
	
//	wire	[3:0]	ifmstream4_0;  
//	wire	[3:0]	ifmstream4_1;  
//	wire	[3:0]	ifmstream4_2;  
//	wire	[3:0]	ifmstream4_3;  
//	wire	[3:0]	ifmstream4_4;  
//	wire	[3:0]	ifmstream4_5;  
//	wire	[3:0]	ifmstream4_6;  
//	wire	[3:0]	ifmstream4_7;  
	

	
	wire	[71:0]	ifmstream_sub_zp_0;
	wire	[71:0]	ifmstream_sub_zp_1;
	wire	[71:0]	ifmstream_sub_zp_2;
	wire	[71:0]	ifmstream_sub_zp_3;
	wire	[71:0]	ifmstream_sub_zp_4;
	wire	[71:0]	ifmstream_sub_zp_5;
	wire	[71:0]	ifmstream_sub_zp_6;
	wire	[71:0]	ifmstream_sub_zp_7;
	
//	wire	[3:0]	ifmstream_sub4_zp_0;
//	wire	[3:0]	ifmstream_sub4_zp_1;
//	wire	[3:0]	ifmstream_sub4_zp_2;
//	wire	[3:0]	ifmstream_sub4_zp_3;
//	wire	[3:0]	ifmstream_sub4_zp_4;
//	wire	[3:0]	ifmstream_sub4_zp_5;
//	wire	[3:0]	ifmstream_sub4_zp_6;
//	wire	[3:0]	ifmstream_sub4_zp_7;
	
//	wire	[35:0]	ifm_4win3x3_0;
//	wire	[35:0]	ifm_4win3x3_1;
//	wire	[35:0]	ifm_4win3x3_2;
//	wire	[35:0]	ifm_4win3x3_3;
//	wire	[35:0]	ifm_4win3x3_4;
//	wire	[35:0]	ifm_4win3x3_5;
//	wire	[35:0]	ifm_4win3x3_6;
//	wire	[35:0]	ifm_4win3x3_7;

	
	
	wire	[71:0]	ifm_win3x3_0;
	wire	[71:0]	ifm_win3x3_1;
	wire	[71:0]	ifm_win3x3_2;
	wire	[71:0]	ifm_win3x3_3;
	wire	[71:0]	ifm_win3x3_4;
	wire	[71:0]	ifm_win3x3_5;
	wire	[71:0]	ifm_win3x3_6;
	wire	[71:0]	ifm_win3x3_7;
	
	wire	[71:0]	weight_win3x3_00;
	wire	[71:0]	weight_win3x3_01;
	wire	[71:0]	weight_win3x3_02;
	wire	[71:0]	weight_win3x3_03;
	wire	[71:0]	weight_win3x3_04;
	wire	[71:0]	weight_win3x3_05;
	wire	[71:0]	weight_win3x3_06;
	wire	[71:0]	weight_win3x3_07;
	
	wire	[71:0]	weight_win3x3_10;
	wire	[71:0]	weight_win3x3_11;
	wire	[71:0]	weight_win3x3_12;
	wire	[71:0]	weight_win3x3_13;
	wire	[71:0]	weight_win3x3_14;
	wire	[71:0]	weight_win3x3_15;
	wire	[71:0]	weight_win3x3_16;
	wire	[71:0]	weight_win3x3_17;
	
	wire	[71:0]	weight_win3x3_20;
	wire	[71:0]	weight_win3x3_21;
	wire	[71:0]	weight_win3x3_22;
	wire	[71:0]	weight_win3x3_23;
	wire	[71:0]	weight_win3x3_24;
	wire	[71:0]	weight_win3x3_25;
	wire	[71:0]	weight_win3x3_26;
	wire	[71:0]	weight_win3x3_27;
	
	wire	[71:0]	weight_win3x3_30;
	wire	[71:0]	weight_win3x3_31;
	wire	[71:0]	weight_win3x3_32;
	wire	[71:0]	weight_win3x3_33;
	wire	[71:0]	weight_win3x3_34;
	wire	[71:0]	weight_win3x3_35;
	wire	[71:0]	weight_win3x3_36;
	wire	[71:0]	weight_win3x3_37;
	
	wire	[71:0]	weight_win3x3_40;
	wire	[71:0]	weight_win3x3_41;
	wire	[71:0]	weight_win3x3_42;
	wire	[71:0]	weight_win3x3_43;
	wire	[71:0]	weight_win3x3_44;
	wire	[71:0]	weight_win3x3_45;
	wire	[71:0]	weight_win3x3_46;
	wire	[71:0]	weight_win3x3_47;
	
	wire	[71:0]	weight_win3x3_50;
	wire	[71:0]	weight_win3x3_51;
	wire	[71:0]	weight_win3x3_52;
	wire	[71:0]	weight_win3x3_53;
	wire	[71:0]	weight_win3x3_54;
	wire	[71:0]	weight_win3x3_55;
	wire	[71:0]	weight_win3x3_56;
	wire	[71:0]	weight_win3x3_57;
	
	wire	[71:0]	weight_win3x3_60;
	wire	[71:0]	weight_win3x3_61;
	wire	[71:0]	weight_win3x3_62;
	wire	[71:0]	weight_win3x3_63;
	wire	[71:0]	weight_win3x3_64;
	wire	[71:0]	weight_win3x3_65;
	wire	[71:0]	weight_win3x3_66;
	wire	[71:0]	weight_win3x3_67;
	
	wire	[71:0]	weight_win3x3_70;
	wire	[71:0]	weight_win3x3_71;
	wire	[71:0]	weight_win3x3_72;
	wire	[71:0]	weight_win3x3_73;
	wire	[71:0]	weight_win3x3_74;
	wire	[71:0]	weight_win3x3_75;
	wire	[71:0]	weight_win3x3_76;
	wire	[71:0]	weight_win3x3_77;
	
//    wire [35:0]weight_4win3x3_00 ;
//    wire [35:0]weight_4win3x3_01 ;
//    wire [35:0]weight_4win3x3_02 ;
//    wire [35:0]weight_4win3x3_03 ;
//    wire [35:0]weight_4win3x3_04 ;
//    wire [35:0]weight_4win3x3_05 ;
//    wire [35:0]weight_4win3x3_06 ;
//    wire [35:0]weight_4win3x3_07 ;
    
//    wire [35:0]weight_4win3x3_10 ;
//    wire [35:0]weight_4win3x3_11 ;
//    wire [35:0]weight_4win3x3_12 ;
//    wire [35:0]weight_4win3x3_13 ;
//    wire [35:0]weight_4win3x3_14 ;
//    wire [35:0]weight_4win3x3_15 ;
//    wire [35:0]weight_4win3x3_16 ;
//    wire [35:0]weight_4win3x3_17 ;
    
//    wire [35:0]weight_4win3x3_20 ;
//    wire [35:0]weight_4win3x3_21 ;
//    wire [35:0]weight_4win3x3_22 ;
//    wire [35:0]weight_4win3x3_23 ;
//    wire [35:0]weight_4win3x3_24 ;
//    wire [35:0]weight_4win3x3_25 ;
//    wire [35:0]weight_4win3x3_26 ;
//    wire [35:0]weight_4win3x3_27 ;
    
//    wire [35:0]weight_4win3x3_30 ;
//    wire [35:0]weight_4win3x3_31 ;
//    wire [35:0]weight_4win3x3_32 ;
//    wire [35:0]weight_4win3x3_33 ;
//    wire [35:0]weight_4win3x3_34 ;
//    wire [35:0]weight_4win3x3_35 ;
//    wire [35:0]weight_4win3x3_36 ;
//    wire [35:0]weight_4win3x3_37 ;
    
//    wire [35:0]weight_4win3x3_40 ;
//    wire [35:0]weight_4win3x3_41 ;
//    wire [35:0]weight_4win3x3_42 ;
//    wire [35:0]weight_4win3x3_43 ;
//    wire [35:0]weight_4win3x3_44 ;
//    wire [35:0]weight_4win3x3_45 ;
//    wire [35:0]weight_4win3x3_46 ;
//    wire [35:0]weight_4win3x3_47 ;
    
//    wire [35:0]weight_4win3x3_50 ;
//    wire [35:0]weight_4win3x3_51 ;
//    wire [35:0]weight_4win3x3_52 ;
//    wire [35:0]weight_4win3x3_53 ;
//    wire [35:0]weight_4win3x3_54 ;
//    wire [35:0]weight_4win3x3_55 ;
//    wire [35:0]weight_4win3x3_56 ;
//    wire [35:0]weight_4win3x3_57 ;
    
//    wire [35:0]weight_4win3x3_60 ;
//    wire [35:0]weight_4win3x3_61 ;
//    wire [35:0]weight_4win3x3_62 ;
//    wire [35:0]weight_4win3x3_63 ;
//    wire [35:0]weight_4win3x3_64 ;
//    wire [35:0]weight_4win3x3_65 ;
//    wire [35:0]weight_4win3x3_66 ;
//    wire [35:0]weight_4win3x3_67 ;
    
//    wire [35:0]weight_4win3x3_70 ;
//    wire [35:0]weight_4win3x3_71 ;
//    wire [35:0]weight_4win3x3_72 ;
//    wire [35:0]weight_4win3x3_73 ;
//    wire [35:0]weight_4win3x3_74 ;
//    wire [35:0]weight_4win3x3_75 ;
//    wire [35:0]weight_4win3x3_76 ;
//    wire [35:0]weight_4win3x3_77 ;
	
//	wire [7:0] mean_value0          ;
//	wire [7:0] mean_value1          ;
//	wire [7:0] mean_value2          ;
//	wire [7:0] mean_value3          ;
//	wire [7:0] mean_value4          ;
//	wire [7:0] mean_value5          ;
//	wire [7:0] mean_value6          ;
//	wire [7:0] mean_value7          ;
                                    
//	wire [7:0] variance_value0      ;
//	wire [7:0] variance_value1      ;
//	wire [7:0] variance_value2      ;
//	wire [7:0] variance_value3      ;
//	wire [7:0] variance_value4      ;
//	wire [7:0] variance_value5      ;
//	wire [7:0] variance_value6      ;
//	wire [7:0] variance_value7      ;
                                    
//	wire [7:0] scale_value0         ;
//	wire [7:0] scale_value1         ;
//	wire [7:0] scale_value2         ;
//	wire [7:0] scale_value3         ;
//	wire [7:0] scale_value4         ;
//	wire [7:0] scale_value5         ;
//	wire [7:0] scale_value6         ;
//	wire [7:0] scale_value7         ;
                                    
//	wire [7:0] offset_value0        ;
//	wire [7:0] offset_value1        ;
//	wire [7:0] offset_value2        ;
//	wire [7:0] offset_value3        ;
//	wire [7:0] offset_value4        ;
//	wire [7:0] offset_value5        ;
//	wire [7:0] offset_value6        ;
//	wire [7:0] offset_value7        ;
	
	
//    wire [3:0] mean_4value0          ;
//    wire [3:0] mean_4value1          ;
//    wire [3:0] mean_4value2          ;
//    wire [3:0] mean_4value3          ;
//    wire [3:0] mean_4value4          ;
//    wire [3:0] mean_4value5          ;
//    wire [3:0] mean_4value6          ;
//    wire [3:0] mean_4value7          ;
                                
//    wire [3:0] variance_4value0      ;
//    wire [3:0] variance_4value1      ;
//    wire [3:0] variance_4value2      ;
//    wire [3:0] variance_4value3      ;
//    wire [3:0] variance_4value4      ;
//    wire [3:0] variance_4value5      ;
//    wire [3:0] variance_4value6      ;
//    wire [3:0] variance_4value7      ;
                                
//    wire [3:0] scale_4value0         ;
//    wire [3:0] scale_4value1         ;
//    wire [3:0] scale_4value2         ;
//    wire [3:0] scale_4value3         ;
//    wire [3:0] scale_4value4         ;
//    wire [3:0] scale_4value5         ;
//    wire [3:0] scale_4value6         ;
//    wire [3:0] scale_4value7         ;
                                
//    wire [3:0] offset_4value0        ;
//    wire [3:0] offset_4value1        ;
//    wire [3:0] offset_4value2        ;
//    wire [3:0] offset_4value3        ;
//    wire [3:0] offset_4value4        ;
//    wire [3:0] offset_4value5        ;
//    wire [3:0] offset_4value6        ;
//    wire [3:0] offset_4value7        ;
	
	
	

	
	
	wire	[17:0]	bias_0;
	wire	[17:0]	bias_1;
	wire	[17:0]	bias_2;
	wire	[17:0]	bias_3;
	wire	[17:0]	bias_4;
	wire	[17:0]	bias_5;
	wire	[17:0]	bias_6;
	wire	[17:0]	bias_7;
	
	
//   wire  	[9:0] bias4_0  ;
//   wire  	[9:0] bias4_1  ;
//   wire  	[9:0] bias4_2  ;
//   wire  	[9:0] bias4_3  ;
//   wire  	[9:0] bias4_4  ;
//   wire  	[9:0] bias4_5  ;
//   wire  	[9:0] bias4_6  ;
//   wire  	[9:0] bias4_7  ;
	
	

	
	wire	[17:0]	ofm_stream_ch0;
	wire	[17:0]	ofm_stream_ch1;
	wire	[17:0]	ofm_stream_ch2;
	wire	[17:0]	ofm_stream_ch3;
	wire	[17:0]	ofm_stream_ch4;
	wire	[17:0]	ofm_stream_ch5;
	wire	[17:0]	ofm_stream_ch6;
	wire	[17:0]	ofm_stream_ch7;
	
	
    wire [17:0] acc_result_0 ;
    wire [17:0] acc_result_1 ;
    wire [17:0] acc_result_2 ;
    wire [17:0] acc_result_3 ;
    wire [17:0] acc_result_4 ;
    wire [17:0] acc_result_5 ;
    wire [17:0] acc_result_6 ;
    wire [17:0] acc_result_7 ;
	

	wire [7:0] quant_result_0 ;
	wire [7:0] quant_result_1 ;
	wire [7:0] quant_result_2 ;
	wire [7:0] quant_result_3 ;
	wire [7:0] quant_result_4 ;
	wire [7:0] quant_result_5 ;
	wire [7:0] quant_result_6 ;
	wire [7:0] quant_result_7 ;
	
//  wire [3:0] quant_4result_0  ;
//	wire [3:0] quant_4result_1  ;
//	wire [3:0] quant_4result_2  ;
//	wire [3:0] quant_4result_3  ;
//	wire [3:0] quant_4result_4  ;
//	wire [3:0] quant_4result_5  ;
//	wire [3:0] quant_4result_6  ;
//	wire [3:0] quant_4result_7  ;
	
//	wire [3:0]output_4data0  ;
//	wire [3:0]output_4data1  ;
//	wire [3:0]output_4data2  ;
//	wire [3:0]output_4data3  ;
//	wire [3:0]output_4data4  ;
//	wire [3:0]output_4data5  ;
//	wire [3:0]output_4data6  ;
//	wire [3:0]output_4data7  ;
	
//	wire [7:0]output_data0  ;
//	wire [7:0]output_data1  ;
//	wire [7:0]output_data2  ;
//	wire [7:0]output_data3  ;
//	wire [7:0]output_data4  ;
//	wire [7:0]output_data5  ;
//	wire [7:0]output_data6  ;
//	wire [7:0]output_data7  ;
	
//	wire [31:0] bundle_4out  ;
	wire [63:0] bundle_out   ;
	
	
	
	
	
	
	
	
	
	buffer_ifm_1x8
	#(.DEPTH(IFMBUF_DEPTH),.ADDR_BIT(13),.RAM_STYLE_VAL(IFM_RAM_STYLE))
	u_buffer_ifm_1x8
	(
		.clk(clk),
		.bram_addr_write(ifmbuf_bram_addr_write),
		.bram_addr_read(ifmbuf_bram_addr_read),
		.bram_en_write(ifmbuf_bram_en_write),
		.buf_sel(ifmbuf_sel),
	    .rst(rst),
		.int_sel(int_sel),
		.cov_sel(cov_sel),
		
		.in_0(ifm_in_0),
		.in_1(ifm_in_1),
		.in_2(ifm_in_2),
		.in_3(ifm_in_3),
		.in_4(ifm_in_4),
		.in_5(ifm_in_5),
		.in_6(ifm_in_6),
		.in_7(ifm_in_7),
		//int4
//		.in4_0   (in4_0),
//        .in4_1   (in4_1),
//        .in4_2   (in4_2),
//        .in4_3   (in4_3),
//        .in4_4   (in4_4),
//        .in4_5   (in4_5),
//        .in4_6   (in4_6),
//        .in4_7   (in4_7),
	       
//	   .ifmstream4_0 (ifmstream4_0),
//       .ifmstream4_1 (ifmstream4_1),
//       .ifmstream4_2 (ifmstream4_2),
//       .ifmstream4_3 (ifmstream4_3),
//       .ifmstream4_4 (ifmstream4_4),
//       .ifmstream4_5 (ifmstream4_5),
//       .ifmstream4_6 (ifmstream4_6),
//       .ifmstream4_7 (ifmstream4_7),  
//	       //int8
	
		.ifmstream_0(ifmstream_0),
		.ifmstream_1(ifmstream_1),
		.ifmstream_2(ifmstream_2),
		.ifmstream_3(ifmstream_3),
		.ifmstream_4(ifmstream_4),
		.ifmstream_5(ifmstream_5),
		.ifmstream_6(ifmstream_6),
		.ifmstream_7(ifmstream_7)
	);
	buffer_weight_1x8x8
	#(.DEPTH(WEIGHTBUF_DEPTH),.ADDR_BIT(WEIGHTBUF_ADDR_BIT),.RAM_STYLE_VAL(WEIGHT_RAM_STYLE))
	u_buffer_weight_1x8x8
	(
		.clk(clk),
		.rst(rst),
		.clear(weightbuf_waddr_clear),
		.cov_sel(cov_sel),
		.int_sel(int_sel),
		
		.bram_en_write(weightbuf_bram_en_write),
		//int8
		.in_0(weight_in_0),
		.in_1(weight_in_1),
		.in_2(weight_in_2),
		.in_3(weight_in_3),
		.in_4(weight_in_4),
		.in_5(weight_in_5),
		.in_6(weight_in_6),
		.in_7(weight_in_7),
		//int4
//        .in4_0(weight_4in_0),
//        .in4_1(weight_4in_1),
//        .in4_2(weight_4in_2),
//        .in4_3(weight_4in_3),
//        .in4_4(weight_4in_4),
//        .in4_5(weight_4in_5),
//        .in4_6(weight_4in_6),
//        .in4_7(weight_4in_7),
		

		
		.read_addr(weightbuf_read_addr),
		.weight_win3x3_00(weight_win3x3_00),
		.weight_win3x3_01(weight_win3x3_01),
		.weight_win3x3_02(weight_win3x3_02),
		.weight_win3x3_03(weight_win3x3_03),
		.weight_win3x3_04(weight_win3x3_04),
		.weight_win3x3_05(weight_win3x3_05),
		.weight_win3x3_06(weight_win3x3_06),
		.weight_win3x3_07(weight_win3x3_07),
		
		.weight_win3x3_10(weight_win3x3_10),
		.weight_win3x3_11(weight_win3x3_11),
		.weight_win3x3_12(weight_win3x3_12),
		.weight_win3x3_13(weight_win3x3_13),
		.weight_win3x3_14(weight_win3x3_14),
		.weight_win3x3_15(weight_win3x3_15),
		.weight_win3x3_16(weight_win3x3_16),
		.weight_win3x3_17(weight_win3x3_17),
		
		.weight_win3x3_20(weight_win3x3_20),
		.weight_win3x3_21(weight_win3x3_21),
		.weight_win3x3_22(weight_win3x3_22),
		.weight_win3x3_23(weight_win3x3_23),
		.weight_win3x3_24(weight_win3x3_24),
		.weight_win3x3_25(weight_win3x3_25),
		.weight_win3x3_26(weight_win3x3_26),
		.weight_win3x3_27(weight_win3x3_27),
		
		.weight_win3x3_30(weight_win3x3_30),
		.weight_win3x3_31(weight_win3x3_31),
		.weight_win3x3_32(weight_win3x3_32),
		.weight_win3x3_33(weight_win3x3_33),
		.weight_win3x3_34(weight_win3x3_34),
		.weight_win3x3_35(weight_win3x3_35),
		.weight_win3x3_36(weight_win3x3_36),
		.weight_win3x3_37(weight_win3x3_37),
		
		.weight_win3x3_40(weight_win3x3_40),
		.weight_win3x3_41(weight_win3x3_41),
		.weight_win3x3_42(weight_win3x3_42),
		.weight_win3x3_43(weight_win3x3_43),
		.weight_win3x3_44(weight_win3x3_44),
		.weight_win3x3_45(weight_win3x3_45),
		.weight_win3x3_46(weight_win3x3_46),
		.weight_win3x3_47(weight_win3x3_47),
		
		.weight_win3x3_50(weight_win3x3_50),
		.weight_win3x3_51(weight_win3x3_51),
		.weight_win3x3_52(weight_win3x3_52),
		.weight_win3x3_53(weight_win3x3_53),
		.weight_win3x3_54(weight_win3x3_54),
		.weight_win3x3_55(weight_win3x3_55),
		.weight_win3x3_56(weight_win3x3_56),
		.weight_win3x3_57(weight_win3x3_57),
		
		.weight_win3x3_60(weight_win3x3_60),
		.weight_win3x3_61(weight_win3x3_61),
		.weight_win3x3_62(weight_win3x3_62),
		.weight_win3x3_63(weight_win3x3_63),
		.weight_win3x3_64(weight_win3x3_64),
		.weight_win3x3_65(weight_win3x3_65),
		.weight_win3x3_66(weight_win3x3_66),
		.weight_win3x3_67(weight_win3x3_67),
		
		.weight_win3x3_70(weight_win3x3_70),
		.weight_win3x3_71(weight_win3x3_71),
		.weight_win3x3_72(weight_win3x3_72),
		.weight_win3x3_73(weight_win3x3_73),
		.weight_win3x3_74(weight_win3x3_74),
		.weight_win3x3_75(weight_win3x3_75),
		.weight_win3x3_76(weight_win3x3_76),
		.weight_win3x3_77(weight_win3x3_77)
		
		
		
//		//int4
//        .weight_4win3x3_00 (weight_4win3x3_00),
//        .weight_4win3x3_01 (weight_4win3x3_01),
//        .weight_4win3x3_02 (weight_4win3x3_02),
//        .weight_4win3x3_03 (weight_4win3x3_03),
//        .weight_4win3x3_04 (weight_4win3x3_04),
//        .weight_4win3x3_05 (weight_4win3x3_05),
//        .weight_4win3x3_06 (weight_4win3x3_06),
//        .weight_4win3x3_07 (weight_4win3x3_07),

//        .weight_4win3x3_10 (weight_4win3x3_10),
//        .weight_4win3x3_11 (weight_4win3x3_11),
//        .weight_4win3x3_12 (weight_4win3x3_12),
//        .weight_4win3x3_13 (weight_4win3x3_13),
//        .weight_4win3x3_14 (weight_4win3x3_14),
//        .weight_4win3x3_15 (weight_4win3x3_15),
//        .weight_4win3x3_16 (weight_4win3x3_16),
//        .weight_4win3x3_17 (weight_4win3x3_17),
       
//        .weight_4win3x3_20 (weight_4win3x3_20),
//        .weight_4win3x3_21 (weight_4win3x3_21),
//        .weight_4win3x3_22 (weight_4win3x3_22),
//        .weight_4win3x3_23 (weight_4win3x3_23),
//        .weight_4win3x3_24 (weight_4win3x3_24),
//        .weight_4win3x3_25 (weight_4win3x3_25),
//        .weight_4win3x3_26 (weight_4win3x3_26),
//        .weight_4win3x3_27 (weight_4win3x3_27),

//        .weight_4win3x3_30 (weight_4win3x3_30),
//        .weight_4win3x3_31 (weight_4win3x3_31),
//        .weight_4win3x3_32 (weight_4win3x3_32),
//        .weight_4win3x3_33 (weight_4win3x3_33),
//        .weight_4win3x3_34 (weight_4win3x3_34),
//        .weight_4win3x3_35 (weight_4win3x3_35),
//        .weight_4win3x3_36 (weight_4win3x3_36),
//        .weight_4win3x3_37 (weight_4win3x3_37),

//        .weight_4win3x3_40 (weight_4win3x3_40),
//        .weight_4win3x3_41 (weight_4win3x3_41),
//        .weight_4win3x3_42 (weight_4win3x3_42),
//        .weight_4win3x3_43 (weight_4win3x3_43),
//        .weight_4win3x3_44 (weight_4win3x3_44),
//        .weight_4win3x3_45 (weight_4win3x3_45),
//        .weight_4win3x3_46 (weight_4win3x3_46),
//        .weight_4win3x3_47 (weight_4win3x3_47),

//        .weight_4win3x3_50 (weight_4win3x3_50),
//        .weight_4win3x3_51 (weight_4win3x3_51),
//        .weight_4win3x3_52 (weight_4win3x3_52),
//        .weight_4win3x3_53 (weight_4win3x3_53),
//        .weight_4win3x3_54 (weight_4win3x3_54),
//        .weight_4win3x3_55 (weight_4win3x3_55),
//        .weight_4win3x3_56 (weight_4win3x3_56),
//        .weight_4win3x3_57 (weight_4win3x3_57),

//        .weight_4win3x3_60 (weight_4win3x3_60),
//        .weight_4win3x3_61 (weight_4win3x3_61),
//        .weight_4win3x3_62 (weight_4win3x3_62),
//        .weight_4win3x3_63 (weight_4win3x3_63),
//        .weight_4win3x3_64 (weight_4win3x3_64),
//        .weight_4win3x3_65 (weight_4win3x3_65),
//        .weight_4win3x3_66 (weight_4win3x3_66),
//        .weight_4win3x3_67 (weight_4win3x3_67),

//        .weight_4win3x3_70 (weight_4win3x3_70),
//        .weight_4win3x3_71 (weight_4win3x3_71),
//        .weight_4win3x3_72 (weight_4win3x3_72),
//        .weight_4win3x3_73 (weight_4win3x3_73),
//        .weight_4win3x3_74 (weight_4win3x3_74),
//        .weight_4win3x3_75 (weight_4win3x3_75),
//        .weight_4win3x3_76 (weight_4win3x3_76),
//        .weight_4win3x3_77 (weight_4win3x3_77)
		

		
		
	);
	buffer_bias
	#(.DEPTH(BIASBUF_DEPTH),.ADDR_BIT(BIASBUF_ADDR_BIT),.RAM_STYLE_VAL(BIAS_RAM_STYLE))
	u_buffer_bias
	(
		.clk(clk),
		.rst(rst),
		.int_sel(int_sel),
		.clear(biasbuf_waddr_clear),
		.bias_in(bias_in),
		.bram_addr_read(biasbuf_read_addr),
		.bram_en_write(biasbuf_bram_en_write),
		
//		.bias4_in(bias4_in),
		
//        . bias4_0 (bias4_0),
//        . bias4_1 (bias4_1),
//        . bias4_2 (bias4_2),
//        . bias4_3 (bias4_3),
//        . bias4_4 (bias4_4),
//        . bias4_5 (bias4_5),
//        . bias4_6 (bias4_6),
//        . bias4_7 (bias4_7),
		
		.bias_0(bias_0),
		.bias_1(bias_1),
		.bias_2(bias_2),
		.bias_3(bias_3),
		.bias_4(bias_4),
		.bias_5(bias_5),
		.bias_6(bias_6),
		.bias_7(bias_7)
	);
	
//module_buff_batch_norm#(        
//.DEPTH(512),                  
//.ADDR_BIT(9),                 
//.RAM_STYLE_VAL("block")       
//)                                      
//u_module_buff_batch_norm(                                      
//	.clk               (clk    )                ,                            
//	.rst               (rst    )                ,                            
//	.clear             (batchbuf_waddr_clear  )  ,                          
//	.int_sel           (int_sel)                ,                        
//	//int8                                 
//	.batch_norm_in0    (batch_norm_in0)         ,           
//	.batch_norm_in1    (batch_norm_in1)         ,           
//	.batch_norm_in2    (batch_norm_in2)         ,           
//	.batch_norm_in3    (batch_norm_in3)         ,           
//	.batch_norm_in4    (batch_norm_in4)         ,           
//	.batch_norm_in5    (batch_norm_in5)         ,           
//	.batch_norm_in6    (batch_norm_in6)         ,           
//	.batch_norm_in7    (batch_norm_in7)         ,           
//	//int4                                
//	. batch_4norm_in0  ( batch_4norm_in0)      ,          
//    . batch_4norm_in1  ( batch_4norm_in1)      ,       
//    . batch_4norm_in2  ( batch_4norm_in2)      ,       
//    . batch_4norm_in3  ( batch_4norm_in3)      ,       
//    . batch_4norm_in4  ( batch_4norm_in4)      ,       
//    . batch_4norm_in5  ( batch_4norm_in5)      ,       
//    . batch_4norm_in6  ( batch_4norm_in6)      ,       
//    . batch_4norm_in7  ( batch_4norm_in7)      ,       
    	                                  
                                       
//	.addr_read          (batchbuf_read_addr)   ,       
//	.bram_en_write      (batchbuf_bram_en_write)  ,                  
//	//int8                                
//	.mean_value0        (mean_value0)         ,             
//	.mean_value1        (mean_value1)         ,             
//	.mean_value2        (mean_value2)         ,             
//	.mean_value3        (mean_value3)         ,             
//	.mean_value4        (mean_value4)         ,             
//	.mean_value5        (mean_value5)         ,             
//	.mean_value6        (mean_value6)         ,             
//	.mean_value7        (mean_value7)         ,             
                                       
//	.variance_value0    (variance_value0)     ,         
//	.variance_value1    (variance_value1)     ,         
//	.variance_value2    (variance_value2)     ,         
//	.variance_value3    (variance_value3)     ,         
//	.variance_value4    (variance_value4)     ,         
//	.variance_value5    (variance_value5)     ,         
//	.variance_value6    (variance_value6)     ,         
//	.variance_value7    (variance_value7)     ,         
                                       
//	.scale_value0       (scale_value0)        ,            
//	.scale_value1       (scale_value1)        ,            
//	.scale_value2       (scale_value2)        ,            
//	.scale_value3       (scale_value3)        ,            
//	.scale_value4       (scale_value4)        ,            
//	.scale_value5       (scale_value5)        ,            
//	.scale_value6       (scale_value6)        ,            
//	.scale_value7       (scale_value7)        ,            
                         
//	.offset_value0      (offset_value0)        ,           
//	.offset_value1      (offset_value1)        ,           
//	.offset_value2      (offset_value2)        ,           
//	.offset_value3      (offset_value3)        ,           
//	.offset_value4      (offset_value4)        ,           
//	.offset_value5      (offset_value5)        ,           
//	.offset_value6      (offset_value6)        ,           
//	.offset_value7      (offset_value7)        ,           
                                       
	                                      
//	//int4                                
//    .mean_4value0       (mean_4value0   )      ,            
//    .mean_4value1       (mean_4value1   )      ,            
//    .mean_4value2       (mean_4value2   )      ,            
//    .mean_4value3       (mean_4value3   )      ,            
//    .mean_4value4       (mean_4value4   )      ,            
//    .mean_4value5       (mean_4value5   )      ,            
//    .mean_4value6       (mean_4value6   )      ,            
//    .mean_4value7       (mean_4value7   )      ,            
                                  
//    .variance_4value0   (variance_4value0 )      ,        
//    .variance_4value1   (variance_4value1 )      ,        
//    .variance_4value2   (variance_4value2 )      ,        
//    .variance_4value3   (variance_4value3 )      ,        
//    .variance_4value4   (variance_4value4 )      ,        
//    .variance_4value5   (variance_4value5 )      ,        
//    .variance_4value6   (variance_4value6 )      ,        
//    .variance_4value7   (variance_4value7 )      ,        
                  
//    .scale_4value0      (scale_4value0  )      ,           
//    .scale_4value1      (scale_4value1  )      ,           
//    .scale_4value2      (scale_4value2  )      ,           
//    .scale_4value3      (scale_4value3  )      ,           
//    .scale_4value4      (scale_4value4  )      ,           
//    .scale_4value5      (scale_4value5  )      ,           
//    .scale_4value6      (scale_4value6  )      ,           
//    .scale_4value7      (scale_4value7  )      ,           
                  
//    .offset_4value0     (offset_4value0 )      ,          
//    .offset_4value1     (offset_4value1 )      ,          
//    .offset_4value2     (offset_4value2 )      ,          
//    .offset_4value3     (offset_4value3 )      ,          
//    .offset_4value4     (offset_4value4 )      ,          
//    .offset_4value5     (offset_4value5 )      ,          
//    .offset_4value6     (offset_4value6 )      ,          
//    .offset_4value7     (offset_4value7 )                            
	                                                                       
                                       
//);                                     
	

	
	module_sub_zero_point_1x8 u_module_sub_zero_point_1x8
	(
		.clk(clk),
		.zero_point(zero_point_in),
//		.zero_4point(zero_4point_in),
		.int_sel(int_sel),
		.cov_sel(cov_sel),
		.data_in_0(ifmstream_0),
		.data_in_1(ifmstream_1),
		.data_in_2(ifmstream_2),
		.data_in_3(ifmstream_3),
		.data_in_4(ifmstream_4),
		.data_in_5(ifmstream_5),
		.data_in_6(ifmstream_6),
		.data_in_7(ifmstream_7),
		
//		.data_4in_0(ifmstream4_0),
//		.data_4in_1(ifmstream4_1),
//		.data_4in_2(ifmstream4_2),
//		.data_4in_3(ifmstream4_3),
//		.data_4in_4(ifmstream4_4),
//		.data_4in_5(ifmstream4_5),
//		.data_4in_6(ifmstream4_6),
//		.data_4in_7(ifmstream4_7),

		
//		.data_4out_0(ifmstream_sub4_zp_0), 
//        .data_4out_1(ifmstream_sub4_zp_1), 
//        .data_4out_2(ifmstream_sub4_zp_2), 
//        .data_4out_3(ifmstream_sub4_zp_3), 
//        .data_4out_4(ifmstream_sub4_zp_4), 
//        .data_4out_5(ifmstream_sub4_zp_5), 
//        .data_4out_6(ifmstream_sub4_zp_6), 
//        .data_4out_7(ifmstream_sub4_zp_7),  
		

		.data_out_0(ifmstream_sub_zp_0),
		.data_out_1(ifmstream_sub_zp_1),
		.data_out_2(ifmstream_sub_zp_2),
		.data_out_3(ifmstream_sub_zp_3),
		.data_out_4(ifmstream_sub_zp_4),
		.data_out_5(ifmstream_sub_zp_5),
		.data_out_6(ifmstream_sub_zp_6),
		.data_out_7(ifmstream_sub_zp_7)
	);
	linebuffer_3x3_collect
	#(.LEN1(LINEBUFFER_LEN1),.LEN2(LINEBUFFER_LEN2),.LEN3(LINEBUFFER_LEN3),.LEN4(LINEBUFFER_LEN4),.LEN5(LINEBUFFER_LEN5),.LEN6(LINEBUFFER_LEN6))
	u_linebuffer_3x3_collect
	(
		.clk(clk),
		.sel(sel),
		.cov_sel(cov_sel),
//		.int_sel(int_sel),
		
		.ifmstream_0(ifmstream_sub_zp_0),
		.ifmstream_1(ifmstream_sub_zp_1),
		.ifmstream_2(ifmstream_sub_zp_2),
		.ifmstream_3(ifmstream_sub_zp_3),
		.ifmstream_4(ifmstream_sub_zp_4),
		.ifmstream_5(ifmstream_sub_zp_5),
		.ifmstream_6(ifmstream_sub_zp_6),
		.ifmstream_7(ifmstream_sub_zp_7),
		
//		.ifmstream4_0 (ifmstream_sub4_zp_0),
//		.ifmstream4_1 (ifmstream_sub4_zp_1),
//		.ifmstream4_2 (ifmstream_sub4_zp_2),
//		.ifmstream4_3 (ifmstream_sub4_zp_3),
//		.ifmstream4_4 (ifmstream_sub4_zp_4),
//		.ifmstream4_5 (ifmstream_sub4_zp_5),
//		.ifmstream4_6 (ifmstream_sub4_zp_6),
//		.ifmstream4_7 (ifmstream_sub4_zp_7),
		
//		.ifm_4win3x3_0(ifm_4win3x3_0),    
//		.ifm_4win3x3_1(ifm_4win3x3_1),    
//		.ifm_4win3x3_2(ifm_4win3x3_2),    
//		.ifm_4win3x3_3(ifm_4win3x3_3),    
//		.ifm_4win3x3_4(ifm_4win3x3_4),    
//		.ifm_4win3x3_5(ifm_4win3x3_5),    
//		.ifm_4win3x3_6(ifm_4win3x3_6),    
//		.ifm_4win3x3_7(ifm_4win3x3_7),     
	  

		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7)
	);
	module_conv_kernel_1x2x8x4 u_module_conv_kernel_1x2x8x4
	(
		.clk(clk),
		.int_sel(int_sel),
		//int8
		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7),
        //int4
//        .ifm_4win3x3_0 (ifm_4win3x3_0),
//        .ifm_4win3x3_1 (ifm_4win3x3_1),
//        .ifm_4win3x3_2 (ifm_4win3x3_2),
//        .ifm_4win3x3_3 (ifm_4win3x3_3),
//        .ifm_4win3x3_4 (ifm_4win3x3_4),
//        .ifm_4win3x3_5 (ifm_4win3x3_5),
//        .ifm_4win3x3_6 (ifm_4win3x3_6),
//        .ifm_4win3x3_7 (ifm_4win3x3_7),
        

        //int8
		.weight_win3x3_00(weight_win3x3_00),
		.weight_win3x3_01(weight_win3x3_01),
		.weight_win3x3_02(weight_win3x3_02),
		.weight_win3x3_03(weight_win3x3_03),
		.weight_win3x3_04(weight_win3x3_04),
		.weight_win3x3_05(weight_win3x3_05),
		.weight_win3x3_06(weight_win3x3_06),
		.weight_win3x3_07(weight_win3x3_07),
		
		.weight_win3x3_10(weight_win3x3_10),
		.weight_win3x3_11(weight_win3x3_11),
		.weight_win3x3_12(weight_win3x3_12),
		.weight_win3x3_13(weight_win3x3_13),
		.weight_win3x3_14(weight_win3x3_14),
		.weight_win3x3_15(weight_win3x3_15),
		.weight_win3x3_16(weight_win3x3_16),
		.weight_win3x3_17(weight_win3x3_17),
		
		.weight_win3x3_20(weight_win3x3_20),
		.weight_win3x3_21(weight_win3x3_21),
		.weight_win3x3_22(weight_win3x3_22),
		.weight_win3x3_23(weight_win3x3_23),
		.weight_win3x3_24(weight_win3x3_24),
		.weight_win3x3_25(weight_win3x3_25),
		.weight_win3x3_26(weight_win3x3_26),
		.weight_win3x3_27(weight_win3x3_27),
		
		.weight_win3x3_30(weight_win3x3_30),
		.weight_win3x3_31(weight_win3x3_31),
		.weight_win3x3_32(weight_win3x3_32),
		.weight_win3x3_33(weight_win3x3_33),
		.weight_win3x3_34(weight_win3x3_34),
		.weight_win3x3_35(weight_win3x3_35),
		.weight_win3x3_36(weight_win3x3_36),
		.weight_win3x3_37(weight_win3x3_37),
		
		.weight_win3x3_40(weight_win3x3_40),
		.weight_win3x3_41(weight_win3x3_41),
		.weight_win3x3_42(weight_win3x3_42),
		.weight_win3x3_43(weight_win3x3_43),
		.weight_win3x3_44(weight_win3x3_44),
		.weight_win3x3_45(weight_win3x3_45),
		.weight_win3x3_46(weight_win3x3_46),
		.weight_win3x3_47(weight_win3x3_47),
		
		.weight_win3x3_50(weight_win3x3_50),
		.weight_win3x3_51(weight_win3x3_51),
		.weight_win3x3_52(weight_win3x3_52),
		.weight_win3x3_53(weight_win3x3_53),
		.weight_win3x3_54(weight_win3x3_54),
		.weight_win3x3_55(weight_win3x3_55),
		.weight_win3x3_56(weight_win3x3_56),
		.weight_win3x3_57(weight_win3x3_57),
		
		.weight_win3x3_60(weight_win3x3_60),
		.weight_win3x3_61(weight_win3x3_61),
		.weight_win3x3_62(weight_win3x3_62),
		.weight_win3x3_63(weight_win3x3_63),
		.weight_win3x3_64(weight_win3x3_64),
		.weight_win3x3_65(weight_win3x3_65),
		.weight_win3x3_66(weight_win3x3_66),
		.weight_win3x3_67(weight_win3x3_67),
		
		.weight_win3x3_70(weight_win3x3_70),
		.weight_win3x3_71(weight_win3x3_71),
		.weight_win3x3_72(weight_win3x3_72),
		.weight_win3x3_73(weight_win3x3_73),
		.weight_win3x3_74(weight_win3x3_74),
		.weight_win3x3_75(weight_win3x3_75),
		.weight_win3x3_76(weight_win3x3_76),
		.weight_win3x3_77(weight_win3x3_77),
		//int4
//        .weight_4win3x3_00 (weight_4win3x3_00),
//        .weight_4win3x3_01 (weight_4win3x3_01),
//        .weight_4win3x3_02 (weight_4win3x3_02),
//        .weight_4win3x3_03 (weight_4win3x3_03),
//        .weight_4win3x3_04 (weight_4win3x3_04),
//        .weight_4win3x3_05 (weight_4win3x3_05),
//        .weight_4win3x3_06 (weight_4win3x3_06),
//        .weight_4win3x3_07 (weight_4win3x3_07),

//        .weight_4win3x3_10 (weight_4win3x3_10),
//        .weight_4win3x3_11 (weight_4win3x3_11),
//        .weight_4win3x3_12 (weight_4win3x3_12),
//        .weight_4win3x3_13 (weight_4win3x3_13),
//        .weight_4win3x3_14 (weight_4win3x3_14),
//        .weight_4win3x3_15 (weight_4win3x3_15),
//        .weight_4win3x3_16 (weight_4win3x3_16),
//        .weight_4win3x3_17 (weight_4win3x3_17),

//        .weight_4win3x3_20 (weight_4win3x3_20),
//        .weight_4win3x3_21 (weight_4win3x3_21),
//        .weight_4win3x3_22 (weight_4win3x3_22),
//        .weight_4win3x3_23 (weight_4win3x3_23),
//        .weight_4win3x3_24 (weight_4win3x3_24),
//        .weight_4win3x3_25 (weight_4win3x3_25),
//        .weight_4win3x3_26 (weight_4win3x3_26),
//        .weight_4win3x3_27 (weight_4win3x3_27),
        
//        .weight_4win3x3_30 (weight_4win3x3_30),
//        .weight_4win3x3_31 (weight_4win3x3_31),
//        .weight_4win3x3_32 (weight_4win3x3_32),
//        .weight_4win3x3_33 (weight_4win3x3_33),
//        .weight_4win3x3_34 (weight_4win3x3_34),
//        .weight_4win3x3_35 (weight_4win3x3_35),
//        .weight_4win3x3_36 (weight_4win3x3_36),
//        .weight_4win3x3_37 (weight_4win3x3_37),
       
//        .weight_4win3x3_40 (weight_4win3x3_40),
//        .weight_4win3x3_41 (weight_4win3x3_41),
//        .weight_4win3x3_42 (weight_4win3x3_42),
//        .weight_4win3x3_43 (weight_4win3x3_43),
//        .weight_4win3x3_44 (weight_4win3x3_44),
//        .weight_4win3x3_45 (weight_4win3x3_45),
//        .weight_4win3x3_46 (weight_4win3x3_46),
//        .weight_4win3x3_47 (weight_4win3x3_47),

//        .weight_4win3x3_50 (weight_4win3x3_50),
//        .weight_4win3x3_51 (weight_4win3x3_51),
//        .weight_4win3x3_52 (weight_4win3x3_52),
//        .weight_4win3x3_53 (weight_4win3x3_53),
//        .weight_4win3x3_54 (weight_4win3x3_54),
//        .weight_4win3x3_55 (weight_4win3x3_55),
//        .weight_4win3x3_56 (weight_4win3x3_56),
//        .weight_4win3x3_57 (weight_4win3x3_57),

//        .weight_4win3x3_60 (weight_4win3x3_60),
//        .weight_4win3x3_61 (weight_4win3x3_61),
//        .weight_4win3x3_62 (weight_4win3x3_62),
//        .weight_4win3x3_63 (weight_4win3x3_63),
//        .weight_4win3x3_64 (weight_4win3x3_64),
//        .weight_4win3x3_65 (weight_4win3x3_65),
//        .weight_4win3x3_66 (weight_4win3x3_66),
//        .weight_4win3x3_67 (weight_4win3x3_67),
  
//        .weight_4win3x3_70 (weight_4win3x3_70),
//        .weight_4win3x3_71 (weight_4win3x3_71),
//        .weight_4win3x3_72 (weight_4win3x3_72),
//        .weight_4win3x3_73 (weight_4win3x3_73),
//        .weight_4win3x3_74 (weight_4win3x3_74),
//        .weight_4win3x3_75 (weight_4win3x3_75),
//        .weight_4win3x3_76 (weight_4win3x3_76),
//        .weight_4win3x3_77 (weight_4win3x3_77),
//int8
		.bias_0(bias_0),
		.bias_1(bias_1),
		.bias_2(bias_2),
		.bias_3(bias_3),
		.bias_4(bias_4),
		.bias_5(bias_5),
		.bias_6(bias_6),
		.bias_7(bias_7),
		
//	//int4	
//        . bias4_0 (bias4_0),
//        . bias4_1 (bias4_1),
//        . bias4_2 (bias4_2),
//        . bias4_3 (bias4_3),
//        . bias4_4 (bias4_4),
//        . bias4_5 (bias4_5),
//        . bias4_6 (bias4_6),
//        . bias4_7 (bias4_7),
        
		.bias_valid(bias_valid),

		.ofm_stream_ch0(ofm_stream_ch0),
		.ofm_stream_ch1(ofm_stream_ch1),
		.ofm_stream_ch2(ofm_stream_ch2),
		.ofm_stream_ch3(ofm_stream_ch3),
		.ofm_stream_ch4(ofm_stream_ch4),
		.ofm_stream_ch5(ofm_stream_ch5),
		.ofm_stream_ch6(ofm_stream_ch6),
		.ofm_stream_ch7(ofm_stream_ch7)
	);
	module_acc_1x8
	#(.DEPTH(ACC_DEPTH),.ADDR_BIT(ACC_ADDR_BIT))
	u_module_acc_1x8
	(
		.clk            (clk),
		.prev_data_zero (acc_prev_data_zero),
		.curr_data_zero (acc_curr_data_zero),
		
		.read_en        (acc_read_en),
		.write_en       (acc_write_en),
		.read_addr      (acc_read_addr),
		.write_addr     (acc_write_addr),
		
		.curr_data_0    (ofm_stream_ch0),
		.curr_data_1    (ofm_stream_ch1),
		.curr_data_2    (ofm_stream_ch2),
		.curr_data_3    (ofm_stream_ch3),
		.curr_data_4    (ofm_stream_ch4),
		.curr_data_5    (ofm_stream_ch5),
		.curr_data_6    (ofm_stream_ch6),
		.curr_data_7    (ofm_stream_ch7),
		
		.acc_result_0   (acc_result_0),
		.acc_result_1   (acc_result_1),
		.acc_result_2   (acc_result_2),
		.acc_result_3   (acc_result_3),
		.acc_result_4   (acc_result_4),
		.acc_result_5   (acc_result_5),
		.acc_result_6   (acc_result_6),
		.acc_result_7   (acc_result_7)
	);
 module_quant_1x8#()
  u_module_quant_1x8(
	.clk             (clk           )     ,                                
    .scale           (scale         )     ,                
    .shift           (shift         )     ,                     
    .zero_point      (zero_point_in   )     ,                   
    .quant_int_sel   (quant_int_sel   )            ,                                         
    .acc_result_0    (acc_result_0  )     ,         
    .acc_result_1    (acc_result_1  )     ,         
    .acc_result_2    (acc_result_2  )     ,         
    .acc_result_3    (acc_result_3  )     ,         
    .acc_result_4    (acc_result_4  )     ,         
    .acc_result_5    (acc_result_5  )     ,         
    .acc_result_6    (acc_result_6  )     ,         
    .acc_result_7    (acc_result_7  )     ,         
                                                  
    .quant_result_0  (quant_result_0)     ,              
    .quant_result_1  (quant_result_1)     ,              
    .quant_result_2  (quant_result_2)     ,              
    .quant_result_3  (quant_result_3)     ,              
    .quant_result_4  (quant_result_4)     ,              
    .quant_result_5  (quant_result_5)     ,              
    .quant_result_6  (quant_result_6)     ,              
    .quant_result_7  (quant_result_7)         
    
//    .quant_4result_0  (quant_4result_0)     ,              
//    .quant_4result_1  (quant_4result_1)     ,              
//    .quant_4result_2  (quant_4result_2)     ,              
//    .quant_4result_3  (quant_4result_3)     ,              
//    .quant_4result_4  (quant_4result_4)     ,              
//    .quant_4result_5  (quant_4result_5)     ,              
//    .quant_4result_6  (quant_4result_6)     ,              
//    .quant_4result_7  (quant_4result_7)      
    

              

);
	
//module_batch_norm_1x8
//u_module_batch_norm_1x8(
//. clk               (clk             )     ,
//. batch_enable      (batch_enable    )     ,
//. int_sel           (int_sel         )     ,
//. data_vaild        (data_vaild      )      ,
//. input_data0       (quant_result_0   )     ,
//. input_data1       (quant_result_1   )     ,
//. input_data2       (quant_result_2   )     ,
//. input_data3       (quant_result_3   )     ,
//. input_data4       (quant_result_4   )     ,
//. input_data5       (quant_result_5   )     ,
//. input_data6       (quant_result_6   )     ,
//. input_data7       (quant_result_7   )     ,
                     
//. input_4data0       (quant_4result_0   )     ,
//. input_4data1       (quant_4result_1   )     ,
//. input_4data2       (quant_4result_2   )     ,
//. input_4data3       (quant_4result_3   )     ,
//. input_4data4       (quant_4result_4   )     ,
//. input_4data5       (quant_4result_5   )     ,
//. input_4data6       (quant_4result_6   )     ,
//. input_4data7       (quant_4result_7   )     ,


//. mean_value0       (mean_value0     )     ,
//. mean_value1       (mean_value1     )     ,
//. mean_value2       (mean_value2     )     ,
//. mean_value3       (mean_value3     )     ,
//. mean_value4       (mean_value4     )     ,
//. mean_value5       (mean_value5     )     ,
//. mean_value6       (mean_value6     )     ,
//. mean_value7       (mean_value7     )     ,

//. variance_value0   (variance_value0 )     ,
//. variance_value1   (variance_value1 )     ,
//. variance_value2   (variance_value2 )     ,
//. variance_value3   (variance_value3 )     ,
//. variance_value4   (variance_value4 )     ,
//. variance_value5   (variance_value5 )     ,
//. variance_value6   (variance_value6 )     ,
//. variance_value7   (variance_value7 )     ,

//. scale_value0      (scale_value0    )     ,
//. scale_value1      (scale_value1    )     ,
//. scale_value2      (scale_value2    )     ,
//. scale_value3      (scale_value3    )     ,
//. scale_value4      (scale_value4    )     ,
//. scale_value5      (scale_value5    )     ,
//. scale_value6      (scale_value6    )     ,
//. scale_value7      (scale_value7    )     ,

//. offset_value0     (offset_value0   )     , 
//. offset_value1     (offset_value1   )     , 
//. offset_value2     (offset_value2   )     , 
//. offset_value3     (offset_value3   )     , 
//. offset_value4     (offset_value4   )     , 
//. offset_value5     (offset_value5   )     , 
//. offset_value6     (offset_value6   )     , 
//. offset_value7     (offset_value7   )     , 

//. mean_4value0      (mean_4value0    )     ,
//. mean_4value1      (mean_4value1    )     ,
//. mean_4value2      (mean_4value2    )     ,
//. mean_4value3      (mean_4value3    )     ,
//. mean_4value4      (mean_4value4    )     ,
//. mean_4value5      (mean_4value5    )     ,
//. mean_4value6      (mean_4value6    )     ,
//. mean_4value7      (mean_4value7    )     ,

//. variance_4value0  (variance_4value0)     ,
//. variance_4value1  (variance_4value1)     ,
//. variance_4value2  (variance_4value2)     ,
//. variance_4value3  (variance_4value3)     ,
//. variance_4value4  (variance_4value4)     ,
//. variance_4value5  (variance_4value5)     ,
//. variance_4value6  (variance_4value6)     ,
//. variance_4value7  (variance_4value7)     ,

//. scale_4value0     (scale_4value0   )     ,
//. scale_4value1     (scale_4value1   )     ,
//. scale_4value2     (scale_4value2   )     ,
//. scale_4value3     (scale_4value3   )     ,
//. scale_4value4     (scale_4value4   )     ,
//. scale_4value5     (scale_4value5   )     ,
//. scale_4value6     (scale_4value6   )     ,
//. scale_4value7     (scale_4value7   )     ,

//. offset_4value0    (offset_4value0  )     , 
//. offset_4value1    (offset_4value1  )     , 
//. offset_4value2    (offset_4value2  )     , 
//. offset_4value3    (offset_4value3  )     , 
//. offset_4value4    (offset_4value4  )     , 
//. offset_4value5    (offset_4value5  )     , 
//. offset_4value6    (offset_4value6  )     , 
//. offset_4value7    (offset_4value7  )     , 

//. output_data0      (output_data0    )     ,
//. output_data1      (output_data1    )     ,
//. output_data2      (output_data2    )     ,
//. output_data3      (output_data3    )     ,
//. output_data4      (output_data4    )     ,
//. output_data5      (output_data5    )     ,
//. output_data6      (output_data6    )     ,
//. output_data7      (output_data7    )     ,

//. output_4data0     (output_4data0   )     ,
//. output_4data1     (output_4data1   )     ,
//. output_4data2     (output_4data2   )     ,
//. output_4data3     (output_4data3   )     ,
//. output_4data4     (output_4data4   )     ,
//. output_4data5     (output_4data5   )     ,
//. output_4data6     (output_4data6   )     ,
//. output_4data7     (output_4data7   )     

  
//);
	
module_relu_1x8	
u_module_relu_1x8	(	
.	clk           (clk           )  ,	
.	zero_point    (zero_point_in    )  ,
//.   int_sel       (  int_sel     )  , 	
.	data_in_0     (quant_result_0)  , 	
.	data_in_1     (quant_result_1)  , 	
.	data_in_2     (quant_result_2)  , 	
.	data_in_3     (quant_result_3)  , 	
.	data_in_4     (quant_result_4)  , 	
.	data_in_5     (quant_result_5)  , 	
.	data_in_6     (quant_result_6)  , 	
.	data_in_7     (quant_result_7)  , 	

	             
//.   data_4in_0    ( quant_4result_0  )  ,	
//.   data_4in_1    ( quant_4result_1  )  ,	
//.   data_4in_2    ( quant_4result_2  )  ,	
//.   data_4in_3    ( quant_4result_3  )  ,	
//.   data_4in_4    ( quant_4result_4  )  ,	
//.   data_4in_5    ( quant_4result_5  )  ,	
//.   data_4in_6    ( quant_4result_6  )  ,	
//.   data_4in_7    ( quant_4result_7  )  ,	
		          
	              
//.    bundle_4out  (   bundle_4out )  ,	
.    bundle_out	  (   bundle_out  )
);	
	
buffer_ofm
#(
	.DEPTH(114*114),
	.ADDR_BIT(12),
	.RAM_STYLE_VAL("block")
)
u_buffer_ofm(
	 .clk                   (clk              )               ,
	 .bram_write_addr       (ofmbuf_bram_write_addr  )        ,
	 .bram_en_write         (ofmbuf_bram_en_write    )        ,
     .int_sel               (int_sel                 )        ,              
	 .bram_read_addr        (ofmbuf_bram_read_addr)           ,
	 .ofm_store_bundle      ( bundle_out)                     ,  
//	 .ofm_store4_bundle     ( bundle_4out)                     ,  
//	 .ofm_out4_bundle        (ofm_out4_bundle   )               ,
	 .ofm_out_bundle        (ofm_out_bundle   )               
);	
	
	
	
	
	
	
endmodule