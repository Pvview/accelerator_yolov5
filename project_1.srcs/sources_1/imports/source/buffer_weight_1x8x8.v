module buffer_weight_1x8x8
#(
	parameter DEPTH=512,
	parameter ADDR_BIT=9,
	parameter RAM_STYLE_VAL="block"
)
(
	input clk,
	input rst,
	input clear,
	input cov_sel,
	input int_sel,
	//int8
	input bram_en_write,
	input [7:0] in_0,
	input [7:0] in_1,
	input [7:0] in_2,
	input [7:0] in_3,
	input [7:0] in_4,
	input [7:0] in_5,
	input [7:0] in_6,
	input [7:0] in_7,
	
	input [ADDR_BIT-1:0] read_addr,
	output [71:0] weight_win3x3_00,
	output [71:0] weight_win3x3_01,
	output [71:0] weight_win3x3_02,
	output [71:0] weight_win3x3_03,
	output [71:0] weight_win3x3_04,
	output [71:0] weight_win3x3_05,
	output [71:0] weight_win3x3_06,
	output [71:0] weight_win3x3_07,
	
	output [71:0] weight_win3x3_10,
	output [71:0] weight_win3x3_11,
	output [71:0] weight_win3x3_12,
	output [71:0] weight_win3x3_13,
	output [71:0] weight_win3x3_14,
	output [71:0] weight_win3x3_15,
	output [71:0] weight_win3x3_16,
	output [71:0] weight_win3x3_17,
	
	output [71:0] weight_win3x3_20,
	output [71:0] weight_win3x3_21,
	output [71:0] weight_win3x3_22,
	output [71:0] weight_win3x3_23,
	output [71:0] weight_win3x3_24,
	output [71:0] weight_win3x3_25,
	output [71:0] weight_win3x3_26,
	output [71:0] weight_win3x3_27,
	
	output [71:0] weight_win3x3_30,
	output [71:0] weight_win3x3_31,
	output [71:0] weight_win3x3_32,
	output [71:0] weight_win3x3_33,
	output [71:0] weight_win3x3_34,
	output [71:0] weight_win3x3_35,
	output [71:0] weight_win3x3_36,
	output [71:0] weight_win3x3_37,
	
	output [71:0] weight_win3x3_40,
	output [71:0] weight_win3x3_41,
	output [71:0] weight_win3x3_42,
	output [71:0] weight_win3x3_43,
	output [71:0] weight_win3x3_44,
	output [71:0] weight_win3x3_45,
	output [71:0] weight_win3x3_46,
	output [71:0] weight_win3x3_47,
	
	output [71:0] weight_win3x3_50,
	output [71:0] weight_win3x3_51,
	output [71:0] weight_win3x3_52,
	output [71:0] weight_win3x3_53,
	output [71:0] weight_win3x3_54,
	output [71:0] weight_win3x3_55,
	output [71:0] weight_win3x3_56,
	output [71:0] weight_win3x3_57,
	
	output [71:0] weight_win3x3_60,
	output [71:0] weight_win3x3_61,
	output [71:0] weight_win3x3_62,
	output [71:0] weight_win3x3_63,
	output [71:0] weight_win3x3_64,
	output [71:0] weight_win3x3_65,
	output [71:0] weight_win3x3_66,
	output [71:0] weight_win3x3_67,
	
	output [71:0] weight_win3x3_70,
	output [71:0] weight_win3x3_71,
	output [71:0] weight_win3x3_72,
	output [71:0] weight_win3x3_73,
	output [71:0] weight_win3x3_74,
	output [71:0] weight_win3x3_75,
	output [71:0] weight_win3x3_76,
	output [71:0] weight_win3x3_77
	//int4
//	input [3:0] in4_0,
//	input [3:0] in4_1,
//	input [3:0] in4_2,
//	input [3:0] in4_3,
//	input [3:0] in4_4,
//	input [3:0] in4_5,
//	input [3:0] in4_6,
//	input [3:0] in4_7,
	
//	output [35:0] weight_4win3x3_00,    
//	output [35:0] weight_4win3x3_01,    
//	output [35:0] weight_4win3x3_02,    
//	output [35:0] weight_4win3x3_03,    
//	output [35:0] weight_4win3x3_04,    
//	output [35:0] weight_4win3x3_05,    
//	output [35:0] weight_4win3x3_06,    
//	output [35:0] weight_4win3x3_07,    
	                              
//	output [35:0] weight_4win3x3_10,    
//	output [35:0] weight_4win3x3_11,    
//	output [35:0] weight_4win3x3_12,    
//	output [35:0] weight_4win3x3_13,    
//	output [35:0] weight_4win3x3_14,    
//	output [35:0] weight_4win3x3_15,    
//	output [35:0] weight_4win3x3_16,    
//	output [35:0] weight_4win3x3_17,    
	                               
//	output [35:0] weight_4win3x3_20,    
//	output [35:0] weight_4win3x3_21,    
//	output [35:0] weight_4win3x3_22,    
//	output [35:0] weight_4win3x3_23,    
//	output [35:0] weight_4win3x3_24,    
//	output [35:0] weight_4win3x3_25,    
//	output [35:0] weight_4win3x3_26,    
//	output [35:0] weight_4win3x3_27,    
	                              
//	output [35:0] weight_4win3x3_30,    
//	output [35:0] weight_4win3x3_31,    
//	output [35:0] weight_4win3x3_32,    
//	output [35:0] weight_4win3x3_33,    
//	output [35:0] weight_4win3x3_34,    
//	output [35:0] weight_4win3x3_35,    
//	output [35:0] weight_4win3x3_36,    
//	output [35:0] weight_4win3x3_37,    
	                             
//	output [35:0] weight_4win3x3_40,    
//	output [35:0] weight_4win3x3_41,    
//	output [35:0] weight_4win3x3_42,    
//	output [35:0] weight_4win3x3_43,    
//	output [35:0] weight_4win3x3_44,    
//	output [35:0] weight_4win3x3_45,    
//	output [35:0] weight_4win3x3_46,    
//	output [35:0] weight_4win3x3_47,    
	                              
//	output [35:0] weight_4win3x3_50,    
//	output [35:0] weight_4win3x3_51,    
//	output [35:0] weight_4win3x3_52,    
//	output [35:0] weight_4win3x3_53,    
//	output [35:0] weight_4win3x3_54,    
//	output [35:0] weight_4win3x3_55,    
//	output [35:0] weight_4win3x3_56,    
//	output [35:0] weight_4win3x3_57,    
	                               
//	output [35:0] weight_4win3x3_60,    
//	output [35:0] weight_4win3x3_61,    
//	output [35:0] weight_4win3x3_62,    
//	output [35:0] weight_4win3x3_63,    
//	output [35:0] weight_4win3x3_64,    
//	output [35:0] weight_4win3x3_65,    
//	output [35:0] weight_4win3x3_66,    
//	output [35:0] weight_4win3x3_67,    
	                                
//	output [35:0] weight_4win3x3_70,    
//	output [35:0] weight_4win3x3_71,    
//	output [35:0] weight_4win3x3_72,    
//	output [35:0] weight_4win3x3_73,    
//	output [35:0] weight_4win3x3_74,    
//	output [35:0] weight_4win3x3_75,    
//	output [35:0] weight_4win3x3_76,    
//	output [35:0] weight_4win3x3_77    
	

	
	
);
//wire[7:0] in48_0 ;
//wire[7:0] in48_1 ;
//wire[7:0] in48_2 ;
//wire[7:0] in48_3 ;
//wire[7:0] in48_4 ;
//wire[7:0] in48_5 ;
//wire[7:0] in48_6 ;
//wire[7:0] in48_7 ;

//assign in48_0 = (int_sel) ? in4_0 : in_0;
//assign in48_1 = (int_sel) ? in4_1 : in_1;
//assign in48_2 = (int_sel) ? in4_2 : in_2;
//assign in48_3 = (int_sel) ? in4_3 : in_3;
//assign in48_4 = (int_sel) ? in4_4 : in_4;
//assign in48_5 = (int_sel) ? in4_5 : in_5;
//assign in48_6 = (int_sel) ? in4_6 : in_6;
//assign in48_7 = (int_sel) ? in4_7 : in_7;

//assign weight_4win3x3_00 ={weight_win3x3_00 [67:64],weight_win3x3_00 [59:56],weight_win3x3_00 [51:48],weight_win3x3_00 [43:40],weight_win3x3_00 [35:32],weight_win3x3_00 [27:24],weight_win3x3_00 [19:16],weight_win3x3_00 [11:8],weight_win3x3_00 [3:0]}  ;
//assign weight_4win3x3_01 ={weight_win3x3_01 [67:64],weight_win3x3_01 [59:56],weight_win3x3_01 [51:48],weight_win3x3_01 [43:40],weight_win3x3_01 [35:32],weight_win3x3_01 [27:24],weight_win3x3_01 [19:16],weight_win3x3_01 [11:8],weight_win3x3_01 [3:0]}  ;
//assign weight_4win3x3_02 ={weight_win3x3_02 [67:64],weight_win3x3_02 [59:56],weight_win3x3_02 [51:48],weight_win3x3_02 [43:40],weight_win3x3_02 [35:32],weight_win3x3_02 [27:24],weight_win3x3_02 [19:16],weight_win3x3_02 [11:8],weight_win3x3_02 [3:0]}  ;
//assign weight_4win3x3_03 ={weight_win3x3_03 [67:64],weight_win3x3_03 [59:56],weight_win3x3_03 [51:48],weight_win3x3_03 [43:40],weight_win3x3_03 [35:32],weight_win3x3_03 [27:24],weight_win3x3_03 [19:16],weight_win3x3_03 [11:8],weight_win3x3_03 [3:0]}  ;
//assign weight_4win3x3_04 ={weight_win3x3_04 [67:64],weight_win3x3_04 [59:56],weight_win3x3_04 [51:48],weight_win3x3_04 [43:40],weight_win3x3_04 [35:32],weight_win3x3_04 [27:24],weight_win3x3_04 [19:16],weight_win3x3_04 [11:8],weight_win3x3_04 [3:0]}  ;
//assign weight_4win3x3_05 ={weight_win3x3_05 [67:64],weight_win3x3_05 [59:56],weight_win3x3_05 [51:48],weight_win3x3_05 [43:40],weight_win3x3_05 [35:32],weight_win3x3_05 [27:24],weight_win3x3_05 [19:16],weight_win3x3_05 [11:8],weight_win3x3_05 [3:0]}  ;
//assign weight_4win3x3_06 ={weight_win3x3_06 [67:64],weight_win3x3_06 [59:56],weight_win3x3_06 [51:48],weight_win3x3_06 [43:40],weight_win3x3_06 [35:32],weight_win3x3_06 [27:24],weight_win3x3_06 [19:16],weight_win3x3_06 [11:8],weight_win3x3_06 [3:0]}  ;
//assign weight_4win3x3_07 ={weight_win3x3_07 [67:64],weight_win3x3_07 [59:56],weight_win3x3_07 [51:48],weight_win3x3_07 [43:40],weight_win3x3_07 [35:32],weight_win3x3_07 [27:24],weight_win3x3_07 [19:16],weight_win3x3_07 [11:8],weight_win3x3_07 [3:0]}  ;
                                                   
//assign weight_4win3x3_10 ={weight_win3x3_10 [67:64],weight_win3x3_10 [59:56],weight_win3x3_10 [51:48],weight_win3x3_10 [43:40],weight_win3x3_10 [35:32],weight_win3x3_10 [27:24],weight_win3x3_10 [19:16],weight_win3x3_10 [11:8],weight_win3x3_10 [3:0]}  ;
//assign weight_4win3x3_11 ={weight_win3x3_11 [67:64],weight_win3x3_11 [59:56],weight_win3x3_11 [51:48],weight_win3x3_11 [43:40],weight_win3x3_11 [35:32],weight_win3x3_11 [27:24],weight_win3x3_11 [19:16],weight_win3x3_11 [11:8],weight_win3x3_11 [3:0]}  ;
//assign weight_4win3x3_12 ={weight_win3x3_12 [67:64],weight_win3x3_12 [59:56],weight_win3x3_12 [51:48],weight_win3x3_12 [43:40],weight_win3x3_12 [35:32],weight_win3x3_12 [27:24],weight_win3x3_12 [19:16],weight_win3x3_12 [11:8],weight_win3x3_12 [3:0]}  ;
//assign weight_4win3x3_13 ={weight_win3x3_13 [67:64],weight_win3x3_13 [59:56],weight_win3x3_13 [51:48],weight_win3x3_13 [43:40],weight_win3x3_13 [35:32],weight_win3x3_13 [27:24],weight_win3x3_13 [19:16],weight_win3x3_13 [11:8],weight_win3x3_13 [3:0]}  ;
//assign weight_4win3x3_14 ={weight_win3x3_14 [67:64],weight_win3x3_14 [59:56],weight_win3x3_14 [51:48],weight_win3x3_14 [43:40],weight_win3x3_14 [35:32],weight_win3x3_14 [27:24],weight_win3x3_14 [19:16],weight_win3x3_14 [11:8],weight_win3x3_14 [3:0]}  ;
//assign weight_4win3x3_15 ={weight_win3x3_15 [67:64],weight_win3x3_15 [59:56],weight_win3x3_15 [51:48],weight_win3x3_15 [43:40],weight_win3x3_15 [35:32],weight_win3x3_15 [27:24],weight_win3x3_15 [19:16],weight_win3x3_15 [11:8],weight_win3x3_15 [3:0]}  ;
//assign weight_4win3x3_16 ={weight_win3x3_16 [67:64],weight_win3x3_16 [59:56],weight_win3x3_16 [51:48],weight_win3x3_16 [43:40],weight_win3x3_16 [35:32],weight_win3x3_16 [27:24],weight_win3x3_16 [19:16],weight_win3x3_16 [11:8],weight_win3x3_16 [3:0]}  ;
//assign weight_4win3x3_17 ={weight_win3x3_17 [67:64],weight_win3x3_17 [59:56],weight_win3x3_17 [51:48],weight_win3x3_17 [43:40],weight_win3x3_17 [35:32],weight_win3x3_17 [27:24],weight_win3x3_17 [19:16],weight_win3x3_17 [11:8],weight_win3x3_17 [3:0]}  ;
                                                   
//assign weight_4win3x3_20 ={weight_win3x3_20 [67:64],weight_win3x3_20 [59:56],weight_win3x3_20 [51:48],weight_win3x3_20 [43:40],weight_win3x3_20 [35:32],weight_win3x3_20 [27:24],weight_win3x3_20 [19:16],weight_win3x3_20 [11:8],weight_win3x3_20 [3:0]}  ;
//assign weight_4win3x3_21 ={weight_win3x3_21 [67:64],weight_win3x3_21 [59:56],weight_win3x3_21 [51:48],weight_win3x3_21 [43:40],weight_win3x3_21 [35:32],weight_win3x3_21 [27:24],weight_win3x3_21 [19:16],weight_win3x3_21 [11:8],weight_win3x3_21 [3:0]}  ;
//assign weight_4win3x3_22 ={weight_win3x3_22 [67:64],weight_win3x3_22 [59:56],weight_win3x3_22 [51:48],weight_win3x3_22 [43:40],weight_win3x3_22 [35:32],weight_win3x3_22 [27:24],weight_win3x3_22 [19:16],weight_win3x3_22 [11:8],weight_win3x3_22 [3:0]}  ;
//assign weight_4win3x3_23 ={weight_win3x3_23 [67:64],weight_win3x3_23 [59:56],weight_win3x3_23 [51:48],weight_win3x3_23 [43:40],weight_win3x3_23 [35:32],weight_win3x3_23 [27:24],weight_win3x3_23 [19:16],weight_win3x3_23 [11:8],weight_win3x3_23 [3:0]}  ;
//assign weight_4win3x3_24 ={weight_win3x3_24 [67:64],weight_win3x3_24 [59:56],weight_win3x3_24 [51:48],weight_win3x3_24 [43:40],weight_win3x3_24 [35:32],weight_win3x3_24 [27:24],weight_win3x3_24 [19:16],weight_win3x3_24 [11:8],weight_win3x3_24 [3:0]}  ;
//assign weight_4win3x3_25 ={weight_win3x3_25 [67:64],weight_win3x3_25 [59:56],weight_win3x3_25 [51:48],weight_win3x3_25 [43:40],weight_win3x3_25 [35:32],weight_win3x3_25 [27:24],weight_win3x3_25 [19:16],weight_win3x3_25 [11:8],weight_win3x3_25 [3:0]}  ;
//assign weight_4win3x3_26 ={weight_win3x3_26 [67:64],weight_win3x3_26 [59:56],weight_win3x3_26 [51:48],weight_win3x3_26 [43:40],weight_win3x3_26 [35:32],weight_win3x3_26 [27:24],weight_win3x3_26 [19:16],weight_win3x3_26 [11:8],weight_win3x3_26 [3:0]}  ;
//assign weight_4win3x3_27 ={weight_win3x3_27 [67:64],weight_win3x3_27 [59:56],weight_win3x3_27 [51:48],weight_win3x3_27 [43:40],weight_win3x3_27 [35:32],weight_win3x3_27 [27:24],weight_win3x3_27 [19:16],weight_win3x3_27 [11:8],weight_win3x3_27 [3:0]}  ;
                                                   
//assign weight_4win3x3_30 ={weight_win3x3_30 [67:64],weight_win3x3_30 [59:56],weight_win3x3_30 [51:48],weight_win3x3_30 [43:40],weight_win3x3_30 [35:32],weight_win3x3_30 [27:24],weight_win3x3_30 [19:16],weight_win3x3_30 [11:8],weight_win3x3_30 [3:0]}  ;
//assign weight_4win3x3_31 ={weight_win3x3_31 [67:64],weight_win3x3_31 [59:56],weight_win3x3_31 [51:48],weight_win3x3_31 [43:40],weight_win3x3_31 [35:32],weight_win3x3_31 [27:24],weight_win3x3_31 [19:16],weight_win3x3_31 [11:8],weight_win3x3_31 [3:0]}  ;
//assign weight_4win3x3_32 ={weight_win3x3_32 [67:64],weight_win3x3_32 [59:56],weight_win3x3_32 [51:48],weight_win3x3_32 [43:40],weight_win3x3_32 [35:32],weight_win3x3_32 [27:24],weight_win3x3_32 [19:16],weight_win3x3_32 [11:8],weight_win3x3_32 [3:0]}  ;
//assign weight_4win3x3_33 ={weight_win3x3_33 [67:64],weight_win3x3_33 [59:56],weight_win3x3_33 [51:48],weight_win3x3_33 [43:40],weight_win3x3_33 [35:32],weight_win3x3_33 [27:24],weight_win3x3_33 [19:16],weight_win3x3_33 [11:8],weight_win3x3_33 [3:0]}  ;
//assign weight_4win3x3_34 ={weight_win3x3_34 [67:64],weight_win3x3_34 [59:56],weight_win3x3_34 [51:48],weight_win3x3_34 [43:40],weight_win3x3_34 [35:32],weight_win3x3_34 [27:24],weight_win3x3_34 [19:16],weight_win3x3_34 [11:8],weight_win3x3_34 [3:0]}  ;
//assign weight_4win3x3_35 ={weight_win3x3_35 [67:64],weight_win3x3_35 [59:56],weight_win3x3_35 [51:48],weight_win3x3_35 [43:40],weight_win3x3_35 [35:32],weight_win3x3_35 [27:24],weight_win3x3_35 [19:16],weight_win3x3_35 [11:8],weight_win3x3_35 [3:0]}  ;
//assign weight_4win3x3_36 ={weight_win3x3_36 [67:64],weight_win3x3_36 [59:56],weight_win3x3_36 [51:48],weight_win3x3_36 [43:40],weight_win3x3_36 [35:32],weight_win3x3_36 [27:24],weight_win3x3_36 [19:16],weight_win3x3_36 [11:8],weight_win3x3_36 [3:0]}  ;
//assign weight_4win3x3_37 ={weight_win3x3_37 [67:64],weight_win3x3_37 [59:56],weight_win3x3_37 [51:48],weight_win3x3_37 [43:40],weight_win3x3_37 [35:32],weight_win3x3_37 [27:24],weight_win3x3_37 [19:16],weight_win3x3_37 [11:8],weight_win3x3_37 [3:0]}  ;
                                                   
//assign weight_4win3x3_40 ={weight_win3x3_40 [67:64],weight_win3x3_40 [59:56],weight_win3x3_40 [51:48],weight_win3x3_40 [43:40],weight_win3x3_40 [35:32],weight_win3x3_40 [27:24],weight_win3x3_40 [19:16],weight_win3x3_40 [11:8],weight_win3x3_40 [3:0]}  ;
//assign weight_4win3x3_41 ={weight_win3x3_41 [67:64],weight_win3x3_41 [59:56],weight_win3x3_41 [51:48],weight_win3x3_41 [43:40],weight_win3x3_41 [35:32],weight_win3x3_41 [27:24],weight_win3x3_41 [19:16],weight_win3x3_41 [11:8],weight_win3x3_41 [3:0]}  ;
//assign weight_4win3x3_42 ={weight_win3x3_42 [67:64],weight_win3x3_42 [59:56],weight_win3x3_42 [51:48],weight_win3x3_42 [43:40],weight_win3x3_42 [35:32],weight_win3x3_42 [27:24],weight_win3x3_42 [19:16],weight_win3x3_42 [11:8],weight_win3x3_42 [3:0]}  ;
//assign weight_4win3x3_43 ={weight_win3x3_43 [67:64],weight_win3x3_43 [59:56],weight_win3x3_43 [51:48],weight_win3x3_43 [43:40],weight_win3x3_43 [35:32],weight_win3x3_43 [27:24],weight_win3x3_43 [19:16],weight_win3x3_43 [11:8],weight_win3x3_43 [3:0]}  ;
//assign weight_4win3x3_44 ={weight_win3x3_44 [67:64],weight_win3x3_44 [59:56],weight_win3x3_44 [51:48],weight_win3x3_44 [43:40],weight_win3x3_44 [35:32],weight_win3x3_44 [27:24],weight_win3x3_44 [19:16],weight_win3x3_44 [11:8],weight_win3x3_44 [3:0]}  ;
//assign weight_4win3x3_45 ={weight_win3x3_45 [67:64],weight_win3x3_45 [59:56],weight_win3x3_45 [51:48],weight_win3x3_45 [43:40],weight_win3x3_45 [35:32],weight_win3x3_45 [27:24],weight_win3x3_45 [19:16],weight_win3x3_45 [11:8],weight_win3x3_45 [3:0]}  ;
//assign weight_4win3x3_46 ={weight_win3x3_46 [67:64],weight_win3x3_46 [59:56],weight_win3x3_46 [51:48],weight_win3x3_46 [43:40],weight_win3x3_46 [35:32],weight_win3x3_46 [27:24],weight_win3x3_46 [19:16],weight_win3x3_46 [11:8],weight_win3x3_46 [3:0]}  ;
//assign weight_4win3x3_47 ={weight_win3x3_47 [67:64],weight_win3x3_47 [59:56],weight_win3x3_47 [51:48],weight_win3x3_47 [43:40],weight_win3x3_47 [35:32],weight_win3x3_47 [27:24],weight_win3x3_47 [19:16],weight_win3x3_47 [11:8],weight_win3x3_47 [3:0]}  ;
                                                   
//assign weight_4win3x3_50 ={weight_win3x3_50 [67:64],weight_win3x3_50 [59:56],weight_win3x3_50 [51:48],weight_win3x3_50 [43:40],weight_win3x3_50 [35:32],weight_win3x3_50 [27:24],weight_win3x3_50 [19:16],weight_win3x3_50 [11:8],weight_win3x3_50 [3:0]}  ;
//assign weight_4win3x3_51 ={weight_win3x3_51 [67:64],weight_win3x3_51 [59:56],weight_win3x3_51 [51:48],weight_win3x3_51 [43:40],weight_win3x3_51 [35:32],weight_win3x3_51 [27:24],weight_win3x3_51 [19:16],weight_win3x3_51 [11:8],weight_win3x3_51 [3:0]}  ;
//assign weight_4win3x3_52 ={weight_win3x3_52 [67:64],weight_win3x3_52 [59:56],weight_win3x3_52 [51:48],weight_win3x3_52 [43:40],weight_win3x3_52 [35:32],weight_win3x3_52 [27:24],weight_win3x3_52 [19:16],weight_win3x3_52 [11:8],weight_win3x3_52 [3:0]}  ;
//assign weight_4win3x3_53 ={weight_win3x3_53 [67:64],weight_win3x3_53 [59:56],weight_win3x3_53 [51:48],weight_win3x3_53 [43:40],weight_win3x3_53 [35:32],weight_win3x3_53 [27:24],weight_win3x3_53 [19:16],weight_win3x3_53 [11:8],weight_win3x3_53 [3:0]}  ;
//assign weight_4win3x3_54 ={weight_win3x3_54 [67:64],weight_win3x3_54 [59:56],weight_win3x3_54 [51:48],weight_win3x3_54 [43:40],weight_win3x3_54 [35:32],weight_win3x3_54 [27:24],weight_win3x3_54 [19:16],weight_win3x3_54 [11:8],weight_win3x3_54 [3:0]}  ;
//assign weight_4win3x3_55 ={weight_win3x3_55 [67:64],weight_win3x3_55 [59:56],weight_win3x3_55 [51:48],weight_win3x3_55 [43:40],weight_win3x3_55 [35:32],weight_win3x3_55 [27:24],weight_win3x3_55 [19:16],weight_win3x3_55 [11:8],weight_win3x3_55 [3:0]}  ;
//assign weight_4win3x3_56 ={weight_win3x3_56 [67:64],weight_win3x3_56 [59:56],weight_win3x3_56 [51:48],weight_win3x3_56 [43:40],weight_win3x3_56 [35:32],weight_win3x3_56 [27:24],weight_win3x3_56 [19:16],weight_win3x3_56 [11:8],weight_win3x3_56 [3:0]}  ;
//assign weight_4win3x3_57 ={weight_win3x3_57 [67:64],weight_win3x3_57 [59:56],weight_win3x3_57 [51:48],weight_win3x3_57 [43:40],weight_win3x3_57 [35:32],weight_win3x3_57 [27:24],weight_win3x3_57 [19:16],weight_win3x3_57 [11:8],weight_win3x3_57 [3:0]}  ;
                                                   
//assign weight_4win3x3_60 ={weight_win3x3_60 [67:64],weight_win3x3_60 [59:56],weight_win3x3_60 [51:48],weight_win3x3_60 [43:40],weight_win3x3_60 [35:32],weight_win3x3_60 [27:24],weight_win3x3_60 [19:16],weight_win3x3_60 [11:8],weight_win3x3_60 [3:0]}  ;
//assign weight_4win3x3_61 ={weight_win3x3_61 [67:64],weight_win3x3_61 [59:56],weight_win3x3_61 [51:48],weight_win3x3_61 [43:40],weight_win3x3_61 [35:32],weight_win3x3_61 [27:24],weight_win3x3_61 [19:16],weight_win3x3_61 [11:8],weight_win3x3_61 [3:0]}  ;
//assign weight_4win3x3_62 ={weight_win3x3_62 [67:64],weight_win3x3_62 [59:56],weight_win3x3_62 [51:48],weight_win3x3_62 [43:40],weight_win3x3_62 [35:32],weight_win3x3_62 [27:24],weight_win3x3_62 [19:16],weight_win3x3_62 [11:8],weight_win3x3_62 [3:0]}  ;
//assign weight_4win3x3_63 ={weight_win3x3_63 [67:64],weight_win3x3_63 [59:56],weight_win3x3_63 [51:48],weight_win3x3_63 [43:40],weight_win3x3_63 [35:32],weight_win3x3_63 [27:24],weight_win3x3_63 [19:16],weight_win3x3_63 [11:8],weight_win3x3_63 [3:0]}  ;
//assign weight_4win3x3_64 ={weight_win3x3_64 [67:64],weight_win3x3_64 [59:56],weight_win3x3_64 [51:48],weight_win3x3_64 [43:40],weight_win3x3_64 [35:32],weight_win3x3_64 [27:24],weight_win3x3_64 [19:16],weight_win3x3_64 [11:8],weight_win3x3_64 [3:0]}  ;
//assign weight_4win3x3_65 ={weight_win3x3_65 [67:64],weight_win3x3_65 [59:56],weight_win3x3_65 [51:48],weight_win3x3_65 [43:40],weight_win3x3_65 [35:32],weight_win3x3_65 [27:24],weight_win3x3_65 [19:16],weight_win3x3_65 [11:8],weight_win3x3_65 [3:0]}  ;
//assign weight_4win3x3_66 ={weight_win3x3_66 [67:64],weight_win3x3_66 [59:56],weight_win3x3_66 [51:48],weight_win3x3_66 [43:40],weight_win3x3_66 [35:32],weight_win3x3_66 [27:24],weight_win3x3_66 [19:16],weight_win3x3_66 [11:8],weight_win3x3_66 [3:0]}  ;
//assign weight_4win3x3_67 ={weight_win3x3_67 [67:64],weight_win3x3_67 [59:56],weight_win3x3_67 [51:48],weight_win3x3_67 [43:40],weight_win3x3_67 [35:32],weight_win3x3_67 [27:24],weight_win3x3_67 [19:16],weight_win3x3_67 [11:8],weight_win3x3_67 [3:0]}  ;
                                                   
//assign weight_4win3x3_70 ={weight_win3x3_70 [67:64],weight_win3x3_70 [59:56],weight_win3x3_70 [51:48],weight_win3x3_70 [43:40],weight_win3x3_70 [35:32],weight_win3x3_70 [27:24],weight_win3x3_70 [19:16],weight_win3x3_70 [11:8],weight_win3x3_70 [3:0]}  ;
//assign weight_4win3x3_71 ={weight_win3x3_71 [67:64],weight_win3x3_71 [59:56],weight_win3x3_71 [51:48],weight_win3x3_71 [43:40],weight_win3x3_71 [35:32],weight_win3x3_71 [27:24],weight_win3x3_71 [19:16],weight_win3x3_71 [11:8],weight_win3x3_71 [3:0]}  ;
//assign weight_4win3x3_72 ={weight_win3x3_72 [67:64],weight_win3x3_72 [59:56],weight_win3x3_72 [51:48],weight_win3x3_72 [43:40],weight_win3x3_72 [35:32],weight_win3x3_72 [27:24],weight_win3x3_72 [19:16],weight_win3x3_72 [11:8],weight_win3x3_72 [3:0]}  ;
//assign weight_4win3x3_73 ={weight_win3x3_73 [67:64],weight_win3x3_73 [59:56],weight_win3x3_73 [51:48],weight_win3x3_73 [43:40],weight_win3x3_73 [35:32],weight_win3x3_73 [27:24],weight_win3x3_73 [19:16],weight_win3x3_73 [11:8],weight_win3x3_73 [3:0]}  ;
//assign weight_4win3x3_74 ={weight_win3x3_74 [67:64],weight_win3x3_74 [59:56],weight_win3x3_74 [51:48],weight_win3x3_74 [43:40],weight_win3x3_74 [35:32],weight_win3x3_74 [27:24],weight_win3x3_74 [19:16],weight_win3x3_74 [11:8],weight_win3x3_74 [3:0]}  ;
//assign weight_4win3x3_75 ={weight_win3x3_75 [67:64],weight_win3x3_75 [59:56],weight_win3x3_75 [51:48],weight_win3x3_75 [43:40],weight_win3x3_75 [35:32],weight_win3x3_75 [27:24],weight_win3x3_75 [19:16],weight_win3x3_75 [11:8],weight_win3x3_75 [3:0]}  ;
//assign weight_4win3x3_76 ={weight_win3x3_76 [67:64],weight_win3x3_76 [59:56],weight_win3x3_76 [51:48],weight_win3x3_76 [43:40],weight_win3x3_76 [35:32],weight_win3x3_76 [27:24],weight_win3x3_76 [19:16],weight_win3x3_76 [11:8],weight_win3x3_76 [3:0]}  ;
//assign weight_4win3x3_77 ={weight_win3x3_77 [67:64],weight_win3x3_77 [59:56],weight_win3x3_77 [51:48],weight_win3x3_77 [43:40],weight_win3x3_77 [35:32],weight_win3x3_77 [27:24],weight_win3x3_77 [19:16],weight_win3x3_77 [11:8],weight_win3x3_77 [3:0]}  ;


	wire [71:0] weight_0;
	wire [71:0] weight_1;
	wire [71:0] weight_2;
	wire [71:0] weight_3;
	wire [71:0] weight_4;
	wire [71:0] weight_5;
	wire [71:0] weight_6;
	wire [71:0] weight_7;
	
//wire [71:0] in_weight_0;                                                                         
//wire [71:0] in_weight_1;                                                                         
//wire [71:0] in_weight_2;                                                                         
//wire [71:0] in_weight_3;                                                                         
//wire [71:0] in_weight_4;                                                                         
//wire [71:0] in_weight_5;                                                                         
//wire [71:0] in_weight_6;                                                                         
//wire [71:0] in_weight_7;  
	

	reg [7:0] in_0_0;	reg [7:0] in_0_1;	reg [7:0] in_0_2;
	reg [7:0] in_0_3;	reg [7:0] in_0_4;	reg [7:0] in_0_5;
	reg [7:0] in_0_6;	reg [7:0] in_0_7;	reg [7:0] in_0_8;
	
	reg [7:0] in_1_0;	reg [7:0] in_1_1;	reg [7:0] in_1_2;
	reg [7:0] in_1_3;	reg [7:0] in_1_4;	reg [7:0] in_1_5;
	reg [7:0] in_1_6;	reg [7:0] in_1_7;	reg [7:0] in_1_8;
	
	reg [7:0] in_2_0;	reg [7:0] in_2_1;	reg [7:0] in_2_2;
	reg [7:0] in_2_3;	reg [7:0] in_2_4;	reg [7:0] in_2_5;
	reg [7:0] in_2_6;	reg [7:0] in_2_7;	reg [7:0] in_2_8;
	
	reg [7:0] in_3_0;	reg [7:0] in_3_1;	reg [7:0] in_3_2;
	reg [7:0] in_3_3;	reg [7:0] in_3_4;	reg [7:0] in_3_5;
	reg [7:0] in_3_6;	reg [7:0] in_3_7;	reg [7:0] in_3_8;
	
	reg [7:0] in_4_0;	reg [7:0] in_4_1;	reg [7:0] in_4_2;
	reg [7:0] in_4_3;	reg [7:0] in_4_4;	reg [7:0] in_4_5;
	reg [7:0] in_4_6;	reg [7:0] in_4_7;	reg [7:0] in_4_8;
	
	reg [7:0] in_5_0;	reg [7:0] in_5_1;	reg [7:0] in_5_2;
	reg [7:0] in_5_3;	reg [7:0] in_5_4;	reg [7:0] in_5_5;
	reg [7:0] in_5_6;	reg [7:0] in_5_7;	reg [7:0] in_5_8;
	
	reg [7:0] in_6_0;	reg [7:0] in_6_1;	reg [7:0] in_6_2;
	reg [7:0] in_6_3;	reg [7:0] in_6_4;	reg [7:0] in_6_5;
	reg [7:0] in_6_6;	reg [7:0] in_6_7;	reg [7:0] in_6_8;
	
	reg [7:0] in_7_0;	reg [7:0] in_7_1;	reg [7:0] in_7_2;
	reg [7:0] in_7_3;	reg [7:0] in_7_4;	reg [7:0] in_7_5;
	reg [7:0] in_7_6;	reg [7:0] in_7_7;	reg [7:0] in_7_8;
	
	always@(posedge clk) begin
		in_0_0<=in_0;		in_0_1<=in_0_0;		in_0_2<=in_0_1;
		in_0_3<=in_0_2;		in_0_4<=in_0_3;		in_0_5<=in_0_4;
		in_0_6<=in_0_5;		in_0_7<=in_0_6;		in_0_8<=in_0_7;
	end
	
	always@(posedge clk) begin
		in_1_0<=in_1;		in_1_1<=in_1_0;		in_1_2<=in_1_1;
		in_1_3<=in_1_2;		in_1_4<=in_1_3;		in_1_5<=in_1_4;
		in_1_6<=in_1_5;		in_1_7<=in_1_6;		in_1_8<=in_1_7;
	end

	always@(posedge clk) begin
		in_2_0<=in_2;		in_2_1<=in_2_0;		in_2_2<=in_2_1;
		in_2_3<=in_2_2;		in_2_4<=in_2_3;		in_2_5<=in_2_4;
		in_2_6<=in_2_5;		in_2_7<=in_2_6;		in_2_8<=in_2_7;
	end
	
	always@(posedge clk) begin
		in_3_0<=in_3;		in_3_1<=in_3_0;		in_3_2<=in_3_1;
		in_3_3<=in_3_2;		in_3_4<=in_3_3;		in_3_5<=in_3_4;
		in_3_6<=in_3_5;		in_3_7<=in_3_6;		in_3_8<=in_3_7;
	end
	
	always@(posedge clk) begin
		in_4_0<=in_4;		in_4_1<=in_4_0;		in_4_2<=in_4_1;
		in_4_3<=in_4_2;		in_4_4<=in_4_3;		in_4_5<=in_4_4;
		in_4_6<=in_4_5;		in_4_7<=in_4_6;		in_4_8<=in_4_7;
	end

	always@(posedge clk) begin
		in_5_0<=in_5;		in_5_1<=in_5_0;		in_5_2<=in_5_1;
		in_5_3<=in_5_2;		in_5_4<=in_5_3;		in_5_5<=in_5_4;
		in_5_6<=in_5_5;		in_5_7<=in_5_6;		in_5_8<=in_5_7;
	end
	
	always@(posedge clk) begin
		in_6_0<=in_6;		in_6_1<=in_6_0;		in_6_2<=in_6_1;
		in_6_3<=in_6_2;		in_6_4<=in_6_3;		in_6_5<=in_6_4;
		in_6_6<=in_6_5;		in_6_7<=in_6_6;		in_6_8<=in_6_7;
	end
	
	always@(posedge clk) begin
		in_7_0<=in_7;		in_7_1<=in_7_0;		in_7_2<=in_7_1;
		in_7_3<=in_7_2;		in_7_4<=in_7_3;		in_7_5<=in_7_4;
		in_7_6<=in_7_5;		in_7_7<=in_7_6;		in_7_8<=in_7_7;
	end
	
	assign weight_0[7:0]=in_0_8;	assign weight_0[15:8]=in_0_7;	assign weight_0[23:16]=in_0_6;
	assign weight_0[31:24]=in_0_5;	assign weight_0[39:32]=in_0_4;	assign weight_0[47:40]=in_0_3;
	assign weight_0[55:48]=in_0_2;	assign weight_0[63:56]=in_0_1;	assign weight_0[71:64]=in_0_0;
	
	assign weight_1[7:0]=in_1_8;	assign weight_1[15:8]=in_1_7;	assign weight_1[23:16]=in_1_6;
	assign weight_1[31:24]=in_1_5;	assign weight_1[39:32]=in_1_4;	assign weight_1[47:40]=in_1_3;
	assign weight_1[55:48]=in_1_2;	assign weight_1[63:56]=in_1_1;	assign weight_1[71:64]=in_1_0;
	
	assign weight_2[7:0]=in_2_8;	assign weight_2[15:8]=in_2_7;	assign weight_2[23:16]=in_2_6;
	assign weight_2[31:24]=in_2_5;	assign weight_2[39:32]=in_2_4;	assign weight_2[47:40]=in_2_3;
	assign weight_2[55:48]=in_2_2;	assign weight_2[63:56]=in_2_1;	assign weight_2[71:64]=in_2_0;
	
	assign weight_3[7:0]=in_3_8;	assign weight_3[15:8]=in_3_7;	assign weight_3[23:16]=in_3_6;
	assign weight_3[31:24]=in_3_5;	assign weight_3[39:32]=in_3_4;	assign weight_3[47:40]=in_3_3;
	assign weight_3[55:48]=in_3_2;	assign weight_3[63:56]=in_3_1;	assign weight_3[71:64]=in_3_0;
	
	assign weight_4[7:0]=in_4_8;	assign weight_4[15:8]=in_4_7;	assign weight_4[23:16]=in_4_6;
	assign weight_4[31:24]=in_4_5;	assign weight_4[39:32]=in_4_4;	assign weight_4[47:40]=in_4_3;
	assign weight_4[55:48]=in_4_2;	assign weight_4[63:56]=in_4_1;	assign weight_4[71:64]=in_4_0;
	
	assign weight_5[7:0]=in_5_8;	assign weight_5[15:8]=in_5_7;	assign weight_5[23:16]=in_5_6;
	assign weight_5[31:24]=in_5_5;	assign weight_5[39:32]=in_5_4;	assign weight_5[47:40]=in_5_3;
	assign weight_5[55:48]=in_5_2;	assign weight_5[63:56]=in_5_1;	assign weight_5[71:64]=in_5_0;
	
	assign weight_6[7:0]=in_6_8;	assign weight_6[15:8]=in_6_7;	assign weight_6[23:16]=in_6_6;
	assign weight_6[31:24]=in_6_5;	assign weight_6[39:32]=in_6_4;	assign weight_6[47:40]=in_6_3;
	assign weight_6[55:48]=in_6_2;	assign weight_6[63:56]=in_6_1;	assign weight_6[71:64]=in_6_0;
	
	assign weight_7[7:0]=in_7_8;	assign weight_7[15:8]=in_7_7;	assign weight_7[23:16]=in_7_6;
	assign weight_7[31:24]=in_7_5;	assign weight_7[39:32]=in_7_4;	assign weight_7[47:40]=in_7_3;
	assign weight_7[55:48]=in_7_2;	assign weight_7[63:56]=in_7_1;	assign weight_7[71:64]=in_7_0;
	
	
	wire ch0_en;	wire ch1_en;
	wire ch2_en;	wire ch3_en;
	wire ch4_en;	wire ch5_en;
	wire ch6_en;	wire ch7_en;
	
//	wire ch0_en1;	wire ch1_en1;
//	wire ch2_en1;	wire ch3_en1;
//	wire ch4_en1;	wire ch5_en1;
//	wire ch6_en1;	wire ch7_en1;

	
	reg ch0_en_d;	reg ch1_en_d;
	reg ch2_en_d;	reg ch3_en_d;
	reg ch4_en_d;	reg ch5_en_d;
	reg ch6_en_d;	reg ch7_en_d;
	
	reg [ADDR_BIT-1:0] ch0_cnt;	reg [ADDR_BIT-1:0] ch1_cnt;
	reg [ADDR_BIT-1:0] ch2_cnt;	reg [ADDR_BIT-1:0] ch3_cnt;
	reg [ADDR_BIT-1:0] ch4_cnt;	reg [ADDR_BIT-1:0] ch5_cnt;
	reg [ADDR_BIT-1:0] ch6_cnt;	reg [ADDR_BIT-1:0] ch7_cnt;
	
	reg [3:0] cnt_9;	reg [2:0] cnt_8; // reg [2:0] cnt_8_1;
	always@(posedge clk) begin
		if(rst||clear) begin
			cnt_8<=0;
			cnt_9<=0;
		end else begin
			if(bram_en_write) begin
				if(cnt_9==4'b1000) begin
					cnt_9<=0;
					cnt_8<=cnt_8+1;
				end else begin
					cnt_9<=cnt_9+1;
					cnt_8<=cnt_8;
				end
			end
		end
	end
//   	always@(posedge clk) begin
//		if(rst||clear) begin
//			cnt_8_1<=0;
//		end else begin
//			if(bram_en_write) begin
//					cnt_8_1<=cnt_8_1+1;
//				end else begin
//					cnt_8_1<=cnt_8_1;
//				end
//			end
//		end	
	

//	  assign in_weight_0 = (cov_sel) ? weight_0 :    weight_0  ;     //   weight_0        in48_0 
//    assign in_weight_1 = (cov_sel) ? weight_1 :    weight_1  ;     //   weight_1        in48_1
//    assign in_weight_2 = (cov_sel) ? weight_2 :    weight_2  ;     //   weight_2        in48_2
//    assign in_weight_3 = (cov_sel) ? weight_3 :    weight_3  ;     //   weight_3        in48_3
//    assign in_weight_4 = (cov_sel) ? weight_4 :    weight_4  ;     //   weight_4        in48_4
//    assign in_weight_5 = (cov_sel) ? weight_5 :    weight_5  ;     //   weight_5        in48_5
//    assign in_weight_6 = (cov_sel) ? weight_6 :    weight_6  ;     //   weight_6        in48_6
//    assign in_weight_7 = (cov_sel) ? weight_7 :    weight_7  ;     //   weight_7        in48_7

	
	assign ch0_en=bram_en_write&&(cnt_8==3'b000)&&(cnt_9==4'b1000);
	assign ch1_en=bram_en_write&&(cnt_8==3'b001)&&(cnt_9==4'b1000);
	assign ch2_en=bram_en_write&&(cnt_8==3'b010)&&(cnt_9==4'b1000);
	assign ch3_en=bram_en_write&&(cnt_8==3'b011)&&(cnt_9==4'b1000);
	assign ch4_en=bram_en_write&&(cnt_8==3'b100)&&(cnt_9==4'b1000);
	assign ch5_en=bram_en_write&&(cnt_8==3'b101)&&(cnt_9==4'b1000);
	assign ch6_en=bram_en_write&&(cnt_8==3'b110)&&(cnt_9==4'b1000);
	assign ch7_en=bram_en_write&&(cnt_8==3'b111)&&(cnt_9==4'b1000);
	
//	assign ch0_en1=bram_en_write&&(cnt_8_1==3'b000);
//	assign ch1_en1=bram_en_write&&(cnt_8_1==3'b001);
//	assign ch2_en1=bram_en_write&&(cnt_8_1==3'b010);
//	assign ch3_en1=bram_en_write&&(cnt_8_1==3'b011);
//	assign ch4_en1=bram_en_write&&(cnt_8_1==3'b100);
//	assign ch5_en1=bram_en_write&&(cnt_8_1==3'b101);
//	assign ch6_en1=bram_en_write&&(cnt_8_1==3'b110);
//	assign ch7_en1=bram_en_write&&(cnt_8_1==3'b111);
	
	
	always@(posedge clk) begin
		ch0_en_d<=ch0_en;		ch1_en_d<=ch1_en;
		ch2_en_d<=ch2_en;		ch3_en_d<=ch3_en;
		ch4_en_d<=ch4_en;		ch5_en_d<=ch5_en;
		ch6_en_d<=ch6_en;		ch7_en_d<=ch7_en;
		end
//	else begin
//	   ch0_en_d<=ch0_en1;		ch1_en_d<=ch1_en1; 
//	   ch2_en_d<=ch2_en1;		ch3_en_d<=ch3_en1; 
//	   ch4_en_d<=ch4_en1;		ch5_en_d<=ch5_en1; 
//	   ch6_en_d<=ch6_en1;		ch7_en_d<=ch7_en1; 
//	   end

	
	always@(posedge clk) begin
		if(rst||clear) begin
			ch0_cnt<=0;
		end else begin
			if(ch0_en_d) begin
				ch0_cnt<=ch0_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch1_cnt<=0;
		end else begin
			if(ch1_en_d) begin
				ch1_cnt<=ch1_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch2_cnt<=0;
		end else begin
			if(ch2_en_d) begin
				ch2_cnt<=ch2_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch3_cnt<=0;
		end else begin
			if(ch3_en_d) begin
				ch3_cnt<=ch3_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch4_cnt<=0;
		end else begin
			if(ch4_en_d) begin
				ch4_cnt<=ch4_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch5_cnt<=0;
		end else begin
			if(ch5_en_d) begin
				ch5_cnt<=ch5_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch6_cnt<=0;
		end else begin
			if(ch6_en_d) begin
				ch6_cnt<=ch6_cnt+1;
			end
		end
	end
	always@(posedge clk) begin
		if(rst||clear) begin
			ch7_cnt<=0;
		end else begin
			if(ch7_en_d) begin
				ch7_cnt<=ch7_cnt+1;
			end
		end
	end
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_0
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_0),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_00),
		.weight_out_1(weight_win3x3_01),
		.weight_out_2(weight_win3x3_02),
		.weight_out_3(weight_win3x3_03),
		.weight_out_4(weight_win3x3_04),
		.weight_out_5(weight_win3x3_05),
		.weight_out_6(weight_win3x3_06),
		.weight_out_7(weight_win3x3_07)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_1
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_1),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_10),
		.weight_out_1(weight_win3x3_11),
		.weight_out_2(weight_win3x3_12),
		.weight_out_3(weight_win3x3_13),
		.weight_out_4(weight_win3x3_14),
		.weight_out_5(weight_win3x3_15),
		.weight_out_6(weight_win3x3_16),
		.weight_out_7(weight_win3x3_17)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_2
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_2),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_20),
		.weight_out_1(weight_win3x3_21),
		.weight_out_2(weight_win3x3_22),
		.weight_out_3(weight_win3x3_23),
		.weight_out_4(weight_win3x3_24),
		.weight_out_5(weight_win3x3_25),
		.weight_out_6(weight_win3x3_26),
		.weight_out_7(weight_win3x3_27)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_3
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_3),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_30),
		.weight_out_1(weight_win3x3_31),
		.weight_out_2(weight_win3x3_32),
		.weight_out_3(weight_win3x3_33),
		.weight_out_4(weight_win3x3_34),
		.weight_out_5(weight_win3x3_35),
		.weight_out_6(weight_win3x3_36),
		.weight_out_7(weight_win3x3_37)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_4
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_4),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_40),
		.weight_out_1(weight_win3x3_41),
		.weight_out_2(weight_win3x3_42),
		.weight_out_3(weight_win3x3_43),
		.weight_out_4(weight_win3x3_44),
		.weight_out_5(weight_win3x3_45),
		.weight_out_6(weight_win3x3_46),
		.weight_out_7(weight_win3x3_47)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_5
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_5),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_50),
		.weight_out_1(weight_win3x3_51),
		.weight_out_2(weight_win3x3_52),
		.weight_out_3(weight_win3x3_53),
		.weight_out_4(weight_win3x3_54),
		.weight_out_5(weight_win3x3_55),
		.weight_out_6(weight_win3x3_56),
		.weight_out_7(weight_win3x3_57)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_6
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_6),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_60),
		.weight_out_1(weight_win3x3_61),
		.weight_out_2(weight_win3x3_62),
		.weight_out_3(weight_win3x3_63),
		.weight_out_4(weight_win3x3_64),
		.weight_out_5(weight_win3x3_65),
		.weight_out_6(weight_win3x3_66),
		.weight_out_7(weight_win3x3_67)
	);
	
	buffer_weight_1x8
	#(.DEPTH(DEPTH),.ADDR_BIT(ADDR_BIT),.RAM_STYLE_VAL(RAM_STYLE_VAL))
	u_buffer_weight_1x8_7
	(
		.clk(clk),
		.write_addr_0(ch0_cnt),	.write_en_0(ch0_en_d),
		.write_addr_1(ch1_cnt),	.write_en_1(ch1_en_d),
		.write_addr_2(ch2_cnt),	.write_en_2(ch2_en_d),
		.write_addr_3(ch3_cnt),	.write_en_3(ch3_en_d),
		.write_addr_4(ch4_cnt),	.write_en_4(ch4_en_d),
		.write_addr_5(ch5_cnt),	.write_en_5(ch5_en_d),
		.write_addr_6(ch6_cnt),	.write_en_6(ch6_en_d),
		.write_addr_7(ch7_cnt),	.write_en_7(ch7_en_d),
		.weight_in(weight_7),
		.read_addr(read_addr),
		.weight_out_0(weight_win3x3_70),
		.weight_out_1(weight_win3x3_71),
		.weight_out_2(weight_win3x3_72),
		.weight_out_3(weight_win3x3_73),
		.weight_out_4(weight_win3x3_74),
		.weight_out_5(weight_win3x3_75),
		.weight_out_6(weight_win3x3_76),
		.weight_out_7(weight_win3x3_77)
	);
endmodule