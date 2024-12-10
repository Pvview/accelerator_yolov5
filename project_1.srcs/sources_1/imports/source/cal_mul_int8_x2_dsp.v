(*use_dsp="yes"*)
module cal_mult_int8_x2_dsp
(
	input clk,
	input signed [7:0]a,  //weight
	input signed [7:0]b,  //weight
	input signed [7:0]c,  //win
    input int_sel,
	output signed [15:0]ac,
	output signed [15:0]bc
);
	wire signed [26:0]A_PORT;
	wire signed [26:0]D_PORT;
	wire signed [17:0]B_PORT;
	
	reg signed [26:0]A_PORT_REG;
	reg signed [26:0]D_PORT_REG;
	reg signed [17:0]B_PORT_REG_1;
	reg signed [17:0]B_PORT_REG_2;
	reg signed [26:0]A_Plus_D;
	reg signed [44:0]MULT_RES;
	reg signed [44:0]DOUT;
	
	assign A_PORT=   {a[7],a[7:0],{18{1'b0}}}         ;   //(int_sel) ? {a[7],a[7:0],{18{1'b0}}}    :  {{23{a[3]}},a[3:0]}                         ;  
	assign D_PORT=   {{19{b[7]}},b[7:0]}              ;   //(int_sel) ? {{19{b[7]}},b[7:0]}         :  {b[3],b[3:0],{22{1'b0}}}                    ;  
	assign B_PORT=   {{10{1'b0}},c[7:0]}              ;   //(int_sel) ? {{10{1'b0}},c[7:0]}         :  {{3{1'b0}},c[7:4],{7{1'b0}},c[3:0]}         ;  
	
	always@(posedge clk) begin
		A_PORT_REG<=A_PORT;
		D_PORT_REG<=D_PORT;
		B_PORT_REG_1<=B_PORT;
		B_PORT_REG_2<=B_PORT_REG_1;
		A_Plus_D<=A_PORT_REG+D_PORT_REG;
		MULT_RES<=A_Plus_D*B_PORT_REG_2;
		DOUT<=MULT_RES;
	end
	assign ac=  DOUT[33:18]  ;    // A1W2 A2W2     {DOUT[40:33] ,DOUT[29:22]}      (int_sel) ?  DOUT[33:18] : {DOUT[40:33] ,DOUT[29:22]} ; 
	assign bc=  DOUT[15:0]   ;    // A1W1 A2W1     {DOUT[18:11] ,DOUT[7:0]}        (int_sel) ?  DOUT[15:0]  : {DOUT[18:11] ,DOUT[7:0]}   ; 
endmodule         
