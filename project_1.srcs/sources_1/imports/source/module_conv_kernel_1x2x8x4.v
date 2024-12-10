module module_conv_kernel_1x2x8x4
(
	input clk,
	input int_sel,
	//int8
	input [71:0] ifm_win3x3_0,
	input [71:0] ifm_win3x3_1,
	input [71:0] ifm_win3x3_2,
	input [71:0] ifm_win3x3_3,
	input [71:0] ifm_win3x3_4,
	input [71:0] ifm_win3x3_5,
	input [71:0] ifm_win3x3_6,
	input [71:0] ifm_win3x3_7,
	//int4
//	input [35:0] ifm_4win3x3_0,
//	input [35:0] ifm_4win3x3_1,
//	input [35:0] ifm_4win3x3_2,
//	input [35:0] ifm_4win3x3_3,
//	input [35:0] ifm_4win3x3_4,
//	input [35:0] ifm_4win3x3_5,
//	input [35:0] ifm_4win3x3_6,
//	input [35:0] ifm_4win3x3_7,
	
	//int8
	input [71:0] weight_win3x3_00,
	input [71:0] weight_win3x3_01,
	input [71:0] weight_win3x3_02,
	input [71:0] weight_win3x3_03,
	input [71:0] weight_win3x3_04,
	input [71:0] weight_win3x3_05,
	input [71:0] weight_win3x3_06,
	input [71:0] weight_win3x3_07,
	
	input [71:0] weight_win3x3_10,
	input [71:0] weight_win3x3_11,
	input [71:0] weight_win3x3_12,
	input [71:0] weight_win3x3_13,
	input [71:0] weight_win3x3_14,
	input [71:0] weight_win3x3_15,
	input [71:0] weight_win3x3_16,
	input [71:0] weight_win3x3_17,
	
	input [71:0] weight_win3x3_20,
	input [71:0] weight_win3x3_21,
	input [71:0] weight_win3x3_22,
	input [71:0] weight_win3x3_23,
	input [71:0] weight_win3x3_24,
	input [71:0] weight_win3x3_25,
	input [71:0] weight_win3x3_26,
	input [71:0] weight_win3x3_27,
	
	input [71:0] weight_win3x3_30,
	input [71:0] weight_win3x3_31,
	input [71:0] weight_win3x3_32,
	input [71:0] weight_win3x3_33,
	input [71:0] weight_win3x3_34,
	input [71:0] weight_win3x3_35,
	input [71:0] weight_win3x3_36,
	input [71:0] weight_win3x3_37,
	
	input [71:0] weight_win3x3_40,
	input [71:0] weight_win3x3_41,
	input [71:0] weight_win3x3_42,
	input [71:0] weight_win3x3_43,
	input [71:0] weight_win3x3_44,
	input [71:0] weight_win3x3_45,
	input [71:0] weight_win3x3_46,
	input [71:0] weight_win3x3_47,
	
	input [71:0] weight_win3x3_50,
	input [71:0] weight_win3x3_51,
	input [71:0] weight_win3x3_52,
	input [71:0] weight_win3x3_53,
	input [71:0] weight_win3x3_54,
	input [71:0] weight_win3x3_55,
	input [71:0] weight_win3x3_56,
	input [71:0] weight_win3x3_57,
	
	input [71:0] weight_win3x3_60,
	input [71:0] weight_win3x3_61,
	input [71:0] weight_win3x3_62,
	input [71:0] weight_win3x3_63,
	input [71:0] weight_win3x3_64,
	input [71:0] weight_win3x3_65,
	input [71:0] weight_win3x3_66,
	input [71:0] weight_win3x3_67,
	
	input [71:0] weight_win3x3_70,
	input [71:0] weight_win3x3_71,
	input [71:0] weight_win3x3_72,
	input [71:0] weight_win3x3_73,
	input [71:0] weight_win3x3_74,
	input [71:0] weight_win3x3_75,
	input [71:0] weight_win3x3_76,
	input [71:0] weight_win3x3_77,
	
//	//int4
//	input [35:0] weight_4win3x3_00,
//	input [35:0] weight_4win3x3_01,
//	input [35:0] weight_4win3x3_02,
//	input [35:0] weight_4win3x3_03,
//	input [35:0] weight_4win3x3_04,
//	input [35:0] weight_4win3x3_05,
//	input [35:0] weight_4win3x3_06,
//	input [35:0] weight_4win3x3_07,
	
//	input [35:0] weight_4win3x3_10,
//	input [35:0] weight_4win3x3_11,
//	input [35:0] weight_4win3x3_12,
//	input [35:0] weight_4win3x3_13,
//	input [35:0] weight_4win3x3_14,
//	input [35:0] weight_4win3x3_15,
//	input [35:0] weight_4win3x3_16,
//	input [35:0] weight_4win3x3_17,

//	input [35:0] weight_4win3x3_20,
//	input [35:0] weight_4win3x3_21,
//	input [35:0] weight_4win3x3_22,
//	input [35:0] weight_4win3x3_23,
//	input [35:0] weight_4win3x3_24,
//	input [35:0] weight_4win3x3_25,
//	input [35:0] weight_4win3x3_26,
//	input [35:0] weight_4win3x3_27,
	   
//	input [35:0] weight_4win3x3_30,
//	input [35:0] weight_4win3x3_31,
//	input [35:0] weight_4win3x3_32,
//	input [35:0] weight_4win3x3_33,
//	input [35:0] weight_4win3x3_34,
//	input [35:0] weight_4win3x3_35,
//	input [35:0] weight_4win3x3_36,
//	input [35:0] weight_4win3x3_37,

//	input [35:0] weight_4win3x3_40,
//	input [35:0] weight_4win3x3_41,
//	input [35:0] weight_4win3x3_42,
//	input [35:0] weight_4win3x3_43,
//	input [35:0] weight_4win3x3_44,
//	input [35:0] weight_4win3x3_45,
//	input [35:0] weight_4win3x3_46,
//	input [35:0] weight_4win3x3_47,
	
//	input [35:0] weight_4win3x3_50,
//	input [35:0] weight_4win3x3_51,
//	input [35:0] weight_4win3x3_52,
//	input [35:0] weight_4win3x3_53,
//	input [35:0] weight_4win3x3_54,
//	input [35:0] weight_4win3x3_55,
//	input [35:0] weight_4win3x3_56,
//	input [35:0] weight_4win3x3_57,

//	input [35:0] weight_4win3x3_60,
//	input [35:0] weight_4win3x3_61,
//	input [35:0] weight_4win3x3_62,
//	input [35:0] weight_4win3x3_63,
//	input [35:0] weight_4win3x3_64,
//	input [35:0] weight_4win3x3_65,
//	input [35:0] weight_4win3x3_66,
//	input [35:0] weight_4win3x3_67,
	    
//	input [35:0] weight_4win3x3_70,
//	input [35:0] weight_4win3x3_71,
//	input [35:0] weight_4win3x3_72,
//	input [35:0] weight_4win3x3_73,
//	input [35:0] weight_4win3x3_74,
//	input [35:0] weight_4win3x3_75,
//	input [35:0] weight_4win3x3_76,
//	input [35:0] weight_4win3x3_77,

	//int8
	input [17:0] bias_0,
	input [17:0] bias_1,
	input [17:0] bias_2,
	input [17:0] bias_3,
	input [17:0] bias_4,
	input [17:0] bias_5,
	input [17:0] bias_6,
	input [17:0] bias_7,
//	//int4
//	input [9:0] bias4_0,
//	input [9:0] bias4_1,
//	input [9:0] bias4_2,
//	input [9:0] bias4_3,
//	input [9:0] bias4_4,
//	input [9:0] bias4_5,
//	input [9:0] bias4_6,
//	input [9:0] bias4_7,
	
	input bias_valid,
	
	output [17:0] ofm_stream_ch0,
	output [17:0] ofm_stream_ch1,
	output [17:0] ofm_stream_ch2,
	output [17:0] ofm_stream_ch3,
	output [17:0] ofm_stream_ch4,
	output [17:0] ofm_stream_ch5,
	output [17:0] ofm_stream_ch6,
	output [17:0] ofm_stream_ch7
	
	
	
	
);

//wire [17:0] bias48_0   ;
//wire [17:0] bias48_1   ;
//wire [17:0] bias48_2   ;
//wire [17:0] bias48_3   ;
//wire [17:0] bias48_4   ;
//wire [17:0] bias48_5   ;
//wire [17:0] bias48_6   ;
//wire [17:0] bias48_7   ;

//assign bias48_0 = (int_sel)?  bias4_0  : bias_0 ;
//assign bias48_1 = (int_sel)?  bias4_1  : bias_1 ;
//assign bias48_2 = (int_sel)?  bias4_2  : bias_2 ;
//assign bias48_3 = (int_sel)?  bias4_3  : bias_3 ;
//assign bias48_4 = (int_sel)?  bias4_4  : bias_4 ;
//assign bias48_5 = (int_sel)?  bias4_5  : bias_5 ;
//assign bias48_6 = (int_sel)?  bias4_6  : bias_6 ;
//assign bias48_7 = (int_sel)?  bias4_7  : bias_7 ;

//wire[71:0] ifm_48win3x3_0 ;
//wire[71:0] ifm_48win3x3_1 ;
//wire[71:0] ifm_48win3x3_2 ;
//wire[71:0] ifm_48win3x3_3 ;
//wire[71:0] ifm_48win3x3_4 ;
//wire[71:0] ifm_48win3x3_5 ;
//wire[71:0] ifm_48win3x3_6 ;
//wire[71:0] ifm_48win3x3_7 ;

//wire [71:0] weight_48win3x3_00;
//wire [71:0] weight_48win3x3_01;
//wire [71:0] weight_48win3x3_02;
//wire [71:0] weight_48win3x3_03;
//wire [71:0] weight_48win3x3_04;
//wire [71:0] weight_48win3x3_05;
//wire [71:0] weight_48win3x3_06;
//wire [71:0] weight_48win3x3_07;
                              
//wire [71:0] weight_48win3x3_10;
//wire [71:0] weight_48win3x3_11;
//wire [71:0] weight_48win3x3_12;
//wire [71:0] weight_48win3x3_13;
//wire [71:0] weight_48win3x3_14;
//wire [71:0] weight_48win3x3_15;
//wire [71:0] weight_48win3x3_16;
//wire [71:0] weight_48win3x3_17;
                              
//wire [71:0] weight_48win3x3_20;
//wire [71:0] weight_48win3x3_21;
//wire [71:0] weight_48win3x3_22;
//wire [71:0] weight_48win3x3_23;
//wire [71:0] weight_48win3x3_24;
//wire [71:0] weight_48win3x3_25;
//wire [71:0] weight_48win3x3_26;
//wire [71:0] weight_48win3x3_27;
                              
//wire [71:0] weight_48win3x3_30;
//wire [71:0] weight_48win3x3_31;
//wire [71:0] weight_48win3x3_32;
//wire [71:0] weight_48win3x3_33;
//wire [71:0] weight_48win3x3_34;
//wire [71:0] weight_48win3x3_35;
//wire [71:0] weight_48win3x3_36;
//wire [71:0] weight_48win3x3_37;
                              
//wire [71:0] weight_48win3x3_40;
//wire [71:0] weight_48win3x3_41;
//wire [71:0] weight_48win3x3_42;
//wire [71:0] weight_48win3x3_43;
//wire [71:0] weight_48win3x3_44;
//wire [71:0] weight_48win3x3_45;
//wire [71:0] weight_48win3x3_46;
//wire [71:0] weight_48win3x3_47;
                              
//wire [71:0] weight_48win3x3_50;
//wire [71:0] weight_48win3x3_51;
//wire [71:0] weight_48win3x3_52;
//wire [71:0] weight_48win3x3_53;
//wire [71:0] weight_48win3x3_54;
//wire [71:0] weight_48win3x3_55;
//wire [71:0] weight_48win3x3_56;
//wire [71:0] weight_48win3x3_57;
                              
//wire [71:0] weight_48win3x3_60;
//wire [71:0] weight_48win3x3_61;
//wire [71:0] weight_48win3x3_62;
//wire [71:0] weight_48win3x3_63;
//wire [71:0] weight_48win3x3_64;
//wire [71:0] weight_48win3x3_65;
//wire [71:0] weight_48win3x3_66;
//wire [71:0] weight_48win3x3_67;
                             
//wire [71:0] weight_48win3x3_70;
//wire [71:0] weight_48win3x3_71;
//wire [71:0] weight_48win3x3_72;
//wire [71:0] weight_48win3x3_73;
//wire [71:0] weight_48win3x3_74;
//wire [71:0] weight_48win3x3_75;
//wire [71:0] weight_48win3x3_76;
//wire [71:0] weight_48win3x3_77;





//assign ifm_48win3x3_0   = (int_sel)  ? ifm_4win3x3_0 : ifm_win3x3_0 ;
//assign ifm_48win3x3_1   = (int_sel)  ? ifm_4win3x3_1 : ifm_win3x3_1 ;
//assign ifm_48win3x3_2   = (int_sel)  ? ifm_4win3x3_2 : ifm_win3x3_2 ;
//assign ifm_48win3x3_3   = (int_sel)  ? ifm_4win3x3_3 : ifm_win3x3_3 ;
//assign ifm_48win3x3_4   = (int_sel)  ? ifm_4win3x3_4 : ifm_win3x3_4 ;
//assign ifm_48win3x3_5   = (int_sel)  ? ifm_4win3x3_5 : ifm_win3x3_5 ;
//assign ifm_48win3x3_6   = (int_sel)  ? ifm_4win3x3_6 : ifm_win3x3_6 ;
//assign ifm_48win3x3_7   = (int_sel)  ? ifm_4win3x3_7 : ifm_win3x3_7 ;


//assign weight_48win3x3_00   =  (int_sel)    ?       weight_4win3x3_00 : weight_win3x3_00  ;
//assign weight_48win3x3_01   =  (int_sel)    ?       weight_4win3x3_01 : weight_win3x3_01  ;
//assign weight_48win3x3_02   =  (int_sel)    ?       weight_4win3x3_02 : weight_win3x3_02  ;
//assign weight_48win3x3_03   =  (int_sel)    ?       weight_4win3x3_03 : weight_win3x3_03  ;
//assign weight_48win3x3_04   =  (int_sel)    ?       weight_4win3x3_04 : weight_win3x3_04  ;
//assign weight_48win3x3_05   =  (int_sel)    ?       weight_4win3x3_05 : weight_win3x3_05  ;
//assign weight_48win3x3_06   =  (int_sel)    ?       weight_4win3x3_06 : weight_win3x3_06  ;
//assign weight_48win3x3_07   =  (int_sel)    ?       weight_4win3x3_07 : weight_win3x3_07  ;
                                                                
//assign weight_48win3x3_10   =  (int_sel)    ?       weight_4win3x3_10 : weight_win3x3_10  ;
//assign weight_48win3x3_11   =  (int_sel)    ?       weight_4win3x3_11 : weight_win3x3_11  ;
//assign weight_48win3x3_12   =  (int_sel)    ?       weight_4win3x3_12 : weight_win3x3_12  ;
//assign weight_48win3x3_13   =  (int_sel)    ?       weight_4win3x3_13 : weight_win3x3_13  ;
//assign weight_48win3x3_14   =  (int_sel)    ?       weight_4win3x3_14 : weight_win3x3_14  ;
//assign weight_48win3x3_15   =  (int_sel)    ?       weight_4win3x3_15 : weight_win3x3_15  ;
//assign weight_48win3x3_16   =  (int_sel)    ?       weight_4win3x3_16 : weight_win3x3_16  ;
//assign weight_48win3x3_17   =  (int_sel)    ?       weight_4win3x3_17 : weight_win3x3_17  ;
                                                                   
//assign weight_48win3x3_20   =  (int_sel)    ?       weight_4win3x3_20 : weight_win3x3_20  ;
//assign weight_48win3x3_21   =  (int_sel)    ?       weight_4win3x3_21 : weight_win3x3_21  ;
//assign weight_48win3x3_22   =  (int_sel)    ?       weight_4win3x3_22 : weight_win3x3_22  ;
//assign weight_48win3x3_23   =  (int_sel)    ?       weight_4win3x3_23 : weight_win3x3_23  ;
//assign weight_48win3x3_24   =  (int_sel)    ?       weight_4win3x3_24 : weight_win3x3_24  ;
//assign weight_48win3x3_25   =  (int_sel)    ?       weight_4win3x3_25 : weight_win3x3_25  ;
//assign weight_48win3x3_26   =  (int_sel)    ?       weight_4win3x3_26 : weight_win3x3_26  ;
//assign weight_48win3x3_27   =  (int_sel)    ?       weight_4win3x3_27 : weight_win3x3_27  ;
                                                                 
//assign weight_48win3x3_30   =  (int_sel)    ?       weight_4win3x3_30 : weight_win3x3_30  ;
//assign weight_48win3x3_31   =  (int_sel)    ?       weight_4win3x3_31 : weight_win3x3_31  ;
//assign weight_48win3x3_32   =  (int_sel)    ?       weight_4win3x3_32 : weight_win3x3_32  ;
//assign weight_48win3x3_33   =  (int_sel)    ?       weight_4win3x3_33 : weight_win3x3_33  ;
//assign weight_48win3x3_34   =  (int_sel)    ?       weight_4win3x3_34 : weight_win3x3_34  ;
//assign weight_48win3x3_35   =  (int_sel)    ?       weight_4win3x3_35 : weight_win3x3_35  ;
//assign weight_48win3x3_36   =  (int_sel)    ?       weight_4win3x3_36 : weight_win3x3_36  ;
//assign weight_48win3x3_37   =  (int_sel)    ?       weight_4win3x3_37 : weight_win3x3_37  ;
                                                                    
//assign weight_48win3x3_40   =  (int_sel)    ?       weight_4win3x3_40 : weight_win3x3_40  ;
//assign weight_48win3x3_41   =  (int_sel)    ?       weight_4win3x3_41 : weight_win3x3_41  ;
//assign weight_48win3x3_42   =  (int_sel)    ?       weight_4win3x3_42 : weight_win3x3_42  ;
//assign weight_48win3x3_43   =  (int_sel)    ?       weight_4win3x3_43 : weight_win3x3_43  ;
//assign weight_48win3x3_44   =  (int_sel)    ?       weight_4win3x3_44 : weight_win3x3_44  ;
//assign weight_48win3x3_45   =  (int_sel)    ?       weight_4win3x3_45 : weight_win3x3_45  ;
//assign weight_48win3x3_46   =  (int_sel)    ?       weight_4win3x3_46 : weight_win3x3_46  ;
//assign weight_48win3x3_47   =  (int_sel)    ?       weight_4win3x3_47 : weight_win3x3_47  ;
                                                                
//assign weight_48win3x3_50   =  (int_sel)    ?       weight_4win3x3_50 : weight_win3x3_50  ;
//assign weight_48win3x3_51   =  (int_sel)    ?       weight_4win3x3_51 : weight_win3x3_51  ;
//assign weight_48win3x3_52   =  (int_sel)    ?       weight_4win3x3_52 : weight_win3x3_52  ;
//assign weight_48win3x3_53   =  (int_sel)    ?       weight_4win3x3_53 : weight_win3x3_53  ;
//assign weight_48win3x3_54   =  (int_sel)    ?       weight_4win3x3_54 : weight_win3x3_54  ;
//assign weight_48win3x3_55   =  (int_sel)    ?       weight_4win3x3_55 : weight_win3x3_55  ;
//assign weight_48win3x3_56   =  (int_sel)    ?       weight_4win3x3_56 : weight_win3x3_56  ;
//assign weight_48win3x3_57   =  (int_sel)    ?       weight_4win3x3_57 : weight_win3x3_57  ;
                                                                    
//assign weight_48win3x3_60   =  (int_sel)    ?       weight_4win3x3_60 : weight_win3x3_60  ;
//assign weight_48win3x3_61   =  (int_sel)    ?       weight_4win3x3_61 : weight_win3x3_61  ;
//assign weight_48win3x3_62   =  (int_sel)    ?       weight_4win3x3_62 : weight_win3x3_62  ;
//assign weight_48win3x3_63   =  (int_sel)    ?       weight_4win3x3_63 : weight_win3x3_63  ;
//assign weight_48win3x3_64   =  (int_sel)    ?       weight_4win3x3_64 : weight_win3x3_64  ;
//assign weight_48win3x3_65   =  (int_sel)    ?       weight_4win3x3_65 : weight_win3x3_65  ;
//assign weight_48win3x3_66   =  (int_sel)    ?       weight_4win3x3_66 : weight_win3x3_66  ;
//assign weight_48win3x3_67   =  (int_sel)    ?       weight_4win3x3_67 : weight_win3x3_67  ;
                                                                   
//assign weight_48win3x3_70   =  (int_sel)    ?       weight_4win3x3_70 : weight_win3x3_70  ;
//assign weight_48win3x3_71   =  (int_sel)    ?       weight_4win3x3_71 : weight_win3x3_71  ;
//assign weight_48win3x3_72   =  (int_sel)    ?       weight_4win3x3_72 : weight_win3x3_72  ;
//assign weight_48win3x3_73   =  (int_sel)    ?       weight_4win3x3_73 : weight_win3x3_73  ;
//assign weight_48win3x3_74   =  (int_sel)    ?       weight_4win3x3_74 : weight_win3x3_74  ;
//assign weight_48win3x3_75   =  (int_sel)    ?       weight_4win3x3_75 : weight_win3x3_75  ;
//assign weight_48win3x3_76   =  (int_sel)    ?       weight_4win3x3_76 : weight_win3x3_76  ;
//assign weight_48win3x3_77   =  (int_sel)    ?       weight_4win3x3_77 : weight_win3x3_77  ;





	module_conv_kernel_1x2x8 u_module_conv_kernel_1x2x8_0
	(
		.clk(clk),
		.int_sel(int_sel),
		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7),

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
		
		.bias_1(bias_0),
		.bias_2(bias_1),
		.bias_valid(bias_valid),
		
		.ofm_stream_ch1(ofm_stream_ch0),
		.ofm_stream_ch2(ofm_stream_ch1)
	);

	module_conv_kernel_1x2x8 u_module_conv_kernel_1x2x8_1
	(
		.clk(clk),
		.int_sel(int_sel),
		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7),

		.weight_win3x3_00(weight_win3x3_20),
		.weight_win3x3_01(weight_win3x3_21),
		.weight_win3x3_02(weight_win3x3_22),
		.weight_win3x3_03(weight_win3x3_23),
		.weight_win3x3_04(weight_win3x3_24),
		.weight_win3x3_05(weight_win3x3_25),
		.weight_win3x3_06(weight_win3x3_26),
		.weight_win3x3_07(weight_win3x3_27),
		                         
		.weight_win3x3_10(weight_win3x3_30),
		.weight_win3x3_11(weight_win3x3_31),
		.weight_win3x3_12(weight_win3x3_32),
		.weight_win3x3_13(weight_win3x3_33),
		.weight_win3x3_14(weight_win3x3_34),
		.weight_win3x3_15(weight_win3x3_35),
		.weight_win3x3_16(weight_win3x3_36),
		.weight_win3x3_17(weight_win3x3_37),
		
		.bias_1(bias_2),
		.bias_2(bias_3),
		.bias_valid(bias_valid),
		
		.ofm_stream_ch1(ofm_stream_ch2),
		.ofm_stream_ch2(ofm_stream_ch3)
	);

	module_conv_kernel_1x2x8 u_module_conv_kernel_1x2x8_2
	(
		.clk(clk),
		.int_sel(int_sel),
		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7),

		.weight_win3x3_00(weight_win3x3_40),
		.weight_win3x3_01(weight_win3x3_41),
		.weight_win3x3_02(weight_win3x3_42),
		.weight_win3x3_03(weight_win3x3_43),
		.weight_win3x3_04(weight_win3x3_44),
		.weight_win3x3_05(weight_win3x3_45),
		.weight_win3x3_06(weight_win3x3_46),
		.weight_win3x3_07(weight_win3x3_47),
		                         
		.weight_win3x3_10(weight_win3x3_50),
		.weight_win3x3_11(weight_win3x3_51),
		.weight_win3x3_12(weight_win3x3_52),
		.weight_win3x3_13(weight_win3x3_53),
		.weight_win3x3_14(weight_win3x3_54),
		.weight_win3x3_15(weight_win3x3_55),
		.weight_win3x3_16(weight_win3x3_56),
		.weight_win3x3_17(weight_win3x3_57),
		
		.bias_1(bias_4),
		.bias_2(bias_5),
		.bias_valid(bias_valid),
		
		.ofm_stream_ch1(ofm_stream_ch4),
		.ofm_stream_ch2(ofm_stream_ch5)
	);
	
	module_conv_kernel_1x2x8 u_module_conv_kernel_1x2x8_3
	(
		.clk(clk),
		.int_sel(int_sel),
		.ifm_win3x3_0(ifm_win3x3_0),
		.ifm_win3x3_1(ifm_win3x3_1),
		.ifm_win3x3_2(ifm_win3x3_2),
		.ifm_win3x3_3(ifm_win3x3_3),
		.ifm_win3x3_4(ifm_win3x3_4),
		.ifm_win3x3_5(ifm_win3x3_5),
		.ifm_win3x3_6(ifm_win3x3_6),
		.ifm_win3x3_7(ifm_win3x3_7),

		.weight_win3x3_00(weight_win3x3_60),
		.weight_win3x3_01(weight_win3x3_61),
		.weight_win3x3_02(weight_win3x3_62),
		.weight_win3x3_03(weight_win3x3_63),
		.weight_win3x3_04(weight_win3x3_64),
		.weight_win3x3_05(weight_win3x3_65),
		.weight_win3x3_06(weight_win3x3_66),
		.weight_win3x3_07(weight_win3x3_67),
		                         
		.weight_win3x3_10(weight_win3x3_70),
		.weight_win3x3_11(weight_win3x3_71),
		.weight_win3x3_12(weight_win3x3_72),
		.weight_win3x3_13(weight_win3x3_73),
		.weight_win3x3_14(weight_win3x3_74),
		.weight_win3x3_15(weight_win3x3_75),
		.weight_win3x3_16(weight_win3x3_76),
		.weight_win3x3_17(weight_win3x3_77),
		
		.bias_1(bias_6),
		.bias_2(bias_7),
		.bias_valid(bias_valid),
		
		.ofm_stream_ch1(ofm_stream_ch6),
		.ofm_stream_ch2(ofm_stream_ch7)
	);
endmodule