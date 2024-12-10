module buffer_ifm_1x8
#(
	parameter DEPTH=114*114*2,
	parameter ADDR_BIT=15,
	parameter RAM_STYLE_VAL="block"
)
(
	input clk,
	input [ADDR_BIT-2:0] bram_addr_write,
	input [ADDR_BIT-2:0] bram_addr_read,
	input int_sel ,
	input bram_en_write,
	input buf_sel,
	input rst,
	input cov_sel,
	//int4
//	input [3:0] in4_0,
//	input [3:0] in4_1,
//	input [3:0] in4_2,
//	input [3:0] in4_3,
//	input [3:0] in4_4,
//	input [3:0] in4_5,
//	input [3:0] in4_6,
//	input [3:0] in4_7,

	//int8

	input [7:0] in_0,
	input [7:0] in_1,
	input [7:0] in_2,
	input [7:0] in_3,
	input [7:0] in_4,
	input [7:0] in_5,
	input [7:0] in_6,
	input [7:0] in_7,
	//int8
	output [71:0] ifmstream_0,
	output [71:0] ifmstream_1,
	output [71:0] ifmstream_2,
	output [71:0] ifmstream_3,
	output [71:0] ifmstream_4,
	output [71:0] ifmstream_5,
	output [71:0] ifmstream_6,
	output [71:0] ifmstream_7
//	//int4
//	output [3:0] ifmstream4_0,
//	output [3:0] ifmstream4_1,
//	output [3:0] ifmstream4_2,
//	output [3:0] ifmstream4_3,
//	output [3:0] ifmstream4_4,
//	output [3:0] ifmstream4_5,
//	output [3:0] ifmstream4_6,
//	output [3:0] ifmstream4_7

	
	
);
	wire buf_sel_n;
	assign buf_sel_n=~buf_sel;
	wire [ADDR_BIT-1:0] bram_addr_write_extend;
	wire [ADDR_BIT-1:0] bram_addr_read_extend;
//	assign bram_addr_write_extend={buf_sel,bram_addr_write};
	assign bram_addr_read_extend={buf_sel_n,bram_addr_read};
	
//	wire [7:0] in48_0   ;
//	wire [7:0] in48_1   ;
//	wire [7:0] in48_2   ;
//	wire [7:0] in48_3   ;
//	wire [7:0] in48_4   ;
//	wire [7:0] in48_5   ;
//	wire [7:0] in48_6   ;
//	wire [7:0] in48_7   ;
	
//	assign in48_0  =   (int_sel) ? in4_0 :  in_0 ;
//	assign in48_1  =   (int_sel) ? in4_1 :  in_1 ;
//	assign in48_2  =   (int_sel) ? in4_2 :  in_2 ;
//	assign in48_3  =   (int_sel) ? in4_3 :  in_3 ;
//	assign in48_4  =   (int_sel) ? in4_4 :  in_4 ;
//	assign in48_5  =   (int_sel) ? in4_5 :  in_5 ;
//	assign in48_6  =   (int_sel) ? in4_6 :  in_6 ;
//	assign in48_7  =   (int_sel) ? in4_7 :  in_7 ;
	
	
//	assign ifmstream4_0  = ifmstream_0 [3:0] ;
//	assign ifmstream4_1  = ifmstream_1 [3:0] ;
//	assign ifmstream4_2  = ifmstream_2 [3:0] ;
//	assign ifmstream4_3  = ifmstream_3 [3:0] ;
//	assign ifmstream4_4  = ifmstream_4 [3:0] ;
//	assign ifmstream4_5  = ifmstream_5 [3:0] ;
//	assign ifmstream4_6  = ifmstream_6 [3:0] ;
//	assign ifmstream4_7  = ifmstream_7 [3:0] ;
	
wire [71:0] in_9_0;
wire [71:0] in_9_1;
wire [71:0] in_9_2;
wire [71:0] in_9_3;
wire [71:0] in_9_4;
wire [71:0] in_9_5;
wire [71:0] in_9_6;
wire [71:0] in_9_7;


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
	
	assign in_9_0[7:0]=in_0_8;	    assign in_9_0[15:8]=in_0_7;	    assign in_9_0[23:16]=in_0_6;
	assign in_9_0[31:24]=in_0_5;	assign in_9_0[39:32]=in_0_4;	assign in_9_0[47:40]=in_0_3;
	assign in_9_0[55:48]=in_0_2;	assign in_9_0[63:56]=in_0_1;	assign in_9_0[71:64]=in_0_0;
	
	assign in_9_1[7:0]=in_1_8;	    assign in_9_1[15:8]=in_1_7;	    assign in_9_1[23:16]=in_1_6;
	assign in_9_1[31:24]=in_1_5;	assign in_9_1[39:32]=in_1_4;	assign in_9_1[47:40]=in_1_3;
	assign in_9_1[55:48]=in_1_2;	assign in_9_1[63:56]=in_1_1;	assign in_9_1[71:64]=in_1_0;
	
	assign in_9_2[7:0]=in_2_8;	    assign in_9_2[15:8]=in_2_7;	    assign in_9_2[23:16]=in_2_6;
	assign in_9_2[31:24]=in_2_5;	assign in_9_2[39:32]=in_2_4;	assign in_9_2[47:40]=in_2_3;
	assign in_9_2[55:48]=in_2_2;	assign in_9_2[63:56]=in_2_1;	assign in_9_2[71:64]=in_2_0;
	
	assign in_9_3[7:0]=in_3_8;	    assign in_9_3[15:8]=in_3_7;	    assign in_9_3[23:16]=in_3_6;
	assign in_9_3[31:24]=in_3_5;	assign in_9_3[39:32]=in_3_4;	assign in_9_3[47:40]=in_3_3;
	assign in_9_3[55:48]=in_3_2;	assign in_9_3[63:56]=in_3_1;	assign in_9_3[71:64]=in_3_0;
	
	assign in_9_4[7:0]=in_4_8;	    assign in_9_4[15:8]=in_4_7;	    assign in_9_4[23:16]=in_4_6;
	assign in_9_4[31:24]=in_4_5;	assign in_9_4[39:32]=in_4_4;	assign in_9_4[47:40]=in_4_3;
	assign in_9_4[55:48]=in_4_2;	assign in_9_4[63:56]=in_4_1;	assign in_9_4[71:64]=in_4_0;
	
	assign in_9_5[7:0]=in_5_8;	    assign in_9_5[15:8]=in_5_7;	    assign in_9_5[23:16]=in_5_6;
	assign in_9_5[31:24]=in_5_5;	assign in_9_5[39:32]=in_5_4;	assign in_9_5[47:40]=in_5_3;
	assign in_9_5[55:48]=in_5_2;	assign in_9_5[63:56]=in_5_1;	assign in_9_5[71:64]=in_5_0;
	
	assign in_9_6[7:0]=in_6_8;	    assign in_9_6[15:8]=in_6_7;	    assign in_9_6[23:16]=in_6_6;
	assign in_9_6[31:24]=in_6_5;	assign in_9_6[39:32]=in_6_4;	assign in_9_6[47:40]=in_6_3;
	assign in_9_6[55:48]=in_6_2;	assign in_9_6[63:56]=in_6_1;	assign in_9_6[71:64]=in_6_0;
	
	assign in_9_7[7:0]=in_7_8;	    assign in_9_7[15:8]=in_7_7;	    assign in_9_7[23:16]=in_7_6;
	assign in_9_7[31:24]=in_7_5;	assign in_9_7[39:32]=in_7_4;	assign in_9_7[47:40]=in_7_3;
	assign in_9_7[55:48]=in_7_2;	assign in_9_7[63:56]=in_7_1;	assign in_9_7[71:64]=in_7_0;
	
	
	
	wire ch_en;	



	reg ch_en_d;	


	reg [3:0] cnt_9;
always@(posedge clk) begin
		if(rst) begin
			cnt_9<=0;
		end else begin
			if(bram_en_write) begin
				if(cnt_9==4'b1000) begin
					cnt_9<=0;
				end else begin
					cnt_9<=cnt_9+1;
				end
			end
		end
	end


	assign ch_en=bram_en_write&&(cnt_9==4'b1000);
	
   always@(posedge clk) begin
		ch_en_d<=ch_en;	

		end

reg [ADDR_BIT-2:0]ch0_cnt;
	always@(posedge clk) begin
		if(rst) begin
			ch0_cnt<=0;
		end else begin
			if(ch_en_d) begin
				ch0_cnt<=ch0_cnt+1;
			end
		end
	end


assign bram_addr_write_extend = (cov_sel) ? {buf_sel,bram_addr_write}  :  {buf_sel,ch0_cnt}  ;//{buf_sel,ch0_cnt}    {buf_sel,bram_addr_write}
wire en ;
assign en = (cov_sel) ?  bram_en_write : ch_en_d ;  //ch_en_d   bram_en_write


wire [71:0] in_cov_0;
wire [71:0] in_cov_1;
wire [71:0] in_cov_2;
wire [71:0] in_cov_3;
wire [71:0] in_cov_4;
wire [71:0] in_cov_5;
wire [71:0] in_cov_6;
wire [71:0] in_cov_7;

assign   in_cov_0 =     (cov_sel) ?      in_0       :      in_9_0          ;
assign   in_cov_1 =     (cov_sel) ?      in_1       :      in_9_1          ;
assign   in_cov_2 =     (cov_sel) ?      in_2       :      in_9_2          ;
assign   in_cov_3 =     (cov_sel) ?      in_3       :      in_9_3          ;
assign   in_cov_4 =     (cov_sel) ?      in_4       :      in_9_4          ;
assign   in_cov_5 =     (cov_sel) ?      in_5       :      in_9_5          ;
assign   in_cov_6 =     (cov_sel) ?      in_6       :      in_9_6          ;
assign   in_cov_7 =	    (cov_sel) ?      in_7       :      in_9_7          ;


	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_0
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_0),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_0),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_1
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_1),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_1),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_2
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_2),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_2),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_3
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_3),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_3),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_4
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_4),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_4),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_5
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_5),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_5),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_6
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_6),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_6),
		.dout_b()
	);
	com_dual_port_ram
	#(
		.WIDTH(72),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_dual_port_ram_7
	(
		.clk(clk),
		.we_a(1'b0),
		.en_a(1'b1),
		.addr_a(bram_addr_read_extend),
		.di_a(),
		.dout_a(ifmstream_7),
		
		.we_b(1'b1),
		.en_b(en),
		.addr_b(bram_addr_write_extend),
		.di_b(in_cov_7),
		.dout_b()
	);
endmodule