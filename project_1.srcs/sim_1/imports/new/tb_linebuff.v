`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 17:16:03
// Design Name: 
// Module Name: tb_linebuff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_linebuff;
/////////////////////////////////////////
    reg   clk;                                                              
    reg   rst ;   
    wire ap_done  ;
//////////////////////////////////////////  
    reg [4:0] S_AXI_LITE_CTRL_awaddr   ;
    reg [2:0] S_AXI_LITE_CTRL_awprot   ;
    reg       S_AXI_LITE_CTRL_awvalid  ;
    wire      S_AXI_LITE_CTRL_awready  ;

/////////////////////////////////////////////
    reg [31:0]  S_AXI_LITE_CTRL_wdata      ;
    wire [3:0]  S_AXI_LITE_CTRL_wstrb      ;
    reg         S_AXI_LITE_CTRL_wvalid     ;
    wire        S_AXI_LITE_CTRL_wready      ;
////////////////////////////////////////////////
    wire [1:0] S_AXI_LITE_CTRL_bresp        ;
    wire       S_AXI_LITE_CTRL_bvalid       ;
    wire       S_AXI_LITE_CTRL_bready       ;
/////////////////////////////////////////////////    
    reg [4:0]  S_AXI_LITE_CTRL_araddr        ;
    reg [2:0]  S_AXI_LITE_CTRL_arprot        ;
    reg        S_AXI_LITE_CTRL_arvalid       ;
    wire       S_AXI_LITE_CTRL_arready       ;
//////////////////////////////////////////////////   
    wire   [31:0] S_AXI_LITE_CTRL_rdata      ;
    wire   [1:0]  S_AXI_LITE_CTRL_rresp      ;
    wire          S_AXI_LITE_CTRL_rvalid     ;
    wire          S_AXI_LITE_CTRL_rready     ;
///////////////////////////////////////////////////    
    wire         S_AXIS_tready          ;
    reg   [63:0] S_AXIS_tdata           ;
    reg          S_AXIS_tlast           ;
    reg          S_AXIS_tvalid          ;
//////////////////////////////////////////////////
    wire          M_AXIS_tvalid         ;
    wire   [63:0] M_AXIS_tdata          ;
    wire          M_AXIS_tlast          ;
    reg           M_AXIS_tready         ;   
//////////////////////////////////////////////////
//    reg [7:0]     num0                  ;
//    reg [7:0]     num1                  ;
//    reg [7:0]     num2                  ;
//    reg [7:0]     num3                  ; 
//    reg [7:0]     num4                  ; 
//    reg [7:0]     num5                  ;
//    reg [7:0]     num6                  ;
//    reg [7:0]     num7                  ;
    
     
   assign S_AXI_LITE_CTRL_wstrb = 4'b1111;
   
   assign S_AXI_LITE_CTRL_bready = 1'b1;
   
   assign S_AXI_LITE_CTRL_rready = 1'b1;
  
  //assign  S_AXIS_tready = 1'b1         ;

   reg  [7:0] num   ;
   reg  [7:0] num1  ;
   reg  [7:0] red   ;
   reg  [7:0] blue  ;
   reg  [7:0] green ;

 
    //图像属性：图像宽度 图像高度 图像尺寸 图像像素点起始位
integer bmp_width;
integer bmp_high;
integer bmp_size;
integer start_index;

//bmp file id
integer bmp_file_id;
integer bmp_dout_id;
integer dout_txt_id;

//文件句柄
integer h;
//文件bmp文件数据
reg		[7:0]	rd_data  [0:49300];
reg     [7:0]   rd_data2 [0:49300];

//写操作
reg		[23:0]	wr_data;
integer i = 0;
integer index;
integer j = 0;

initial
begin

    
	//打开原始图像
	bmp_file_id = $fopen("38240.bmp","rb");

	//打开输出数据
	dout_txt_id = $fopen("output_file.txt","w+");

	//读取bmp文件
	h = $fread(rd_data,bmp_file_id);

    // 图像宽度
	bmp_width = {rd_data[21], rd_data[20], rd_data[19], rd_data[18]};
	// 图像宽度
	bmp_high = {rd_data[25], rd_data[24], rd_data[23], rd_data[22]};
	// 像素起始位置
	start_index = {rd_data[13], rd_data[12], rd_data[11], rd_data[10]};
	// 图像尺寸
	bmp_size = {rd_data[5], rd_data[4], rd_data[3], rd_data[2]};
	$fclose(bmp_file_id);
    //输出txt
    for(index = start_index; index < bmp_size-2; index = index + 3)begin  //将像素点数据写入txt文件
        wr_data = {rd_data[index + 2], rd_data[index + 1], rd_data[index]};
        $fwrite(dout_txt_id, "%d,", wr_data[7:0]);
        $fwrite(dout_txt_id, "%d,", wr_data[15:8]);
        $fwrite(dout_txt_id, "%d\n", wr_data[23:16]);

    end

    $fclose(dout_txt_id);

   end     
    
    //////////////////////////////////////////////////////////////////传入特征图至ifm_buff///////////////////////////////////////////
initial
begin
    clk = 1'b0 ;
    num   =  8'b0000_0001;
    num1  =  8'b0000_0000;
    red   =  8'b0000_0000;
    blue  =  8'b0000_0000;
    green =  8'b0000_0000;
    
    #10;
          rst     = 1;
            #20 rst     = 0;
        
    
     S_AXIS_tlast  <= 1'b0;
     S_AXIS_tvalid <= 0;   M_AXIS_tready = 1'b1;
     #2;
   
   
        S_AXI_LITE_CTRL_awaddr = 5'h00;
        S_AXI_LITE_CTRL_wdata  = 32'hfff4_0001;  //32'hfff4_0001 进行3x3卷积   32'hfff0_0001 进行1x1卷积
        //test write logic
//        while(S_AXI_LITE_CTRL_awaddr <= 5'h0c)

            S_AXI_LITE_CTRL_awvalid = 1'b1;
            S_AXI_LITE_CTRL_wvalid  =  1'b1;
            #4
            S_AXI_LITE_CTRL_awvalid = 1'b0;
            S_AXI_LITE_CTRL_wvalid  = 1'b0;
            #2
            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata;
            
            #10;

   
    S_AXIS_tvalid <= 1;
    for (index = 54; index < 5000; index = index + 3) begin
         red   = rd_data[index] ;
         blue  = rd_data[index + 1]  ;
         green = rd_data[index + 2]  ;    
        S_AXIS_tdata  <= {{5{8'b0000_0000}},{red},{blue},{green}};
    #2;
    end
             S_AXIS_tlast  <= 1'b0;
             S_AXIS_tvalid <= 0;  
             
    //$finish();
    
            rst     = 1;
            #20 rst     = 0;
        
        S_AXI_LITE_CTRL_awaddr = 5'h00;
        S_AXI_LITE_CTRL_wdata  = 32'hfff4_0101;
        //test write logic
            S_AXI_LITE_CTRL_awvalid = 1'b1;
            S_AXI_LITE_CTRL_wvalid  =  1'b1;
            #4
            S_AXI_LITE_CTRL_awvalid = 1'b0;
            S_AXI_LITE_CTRL_wvalid  = 1'b0;
            #2
            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata;
            #10;


             M_AXIS_tready = 1'b1;
             S_AXIS_tvalid <= 1;
            
            
    for (index = 54; index < 4151; index = index + 3) begin
         red   = rd_data[index] ;
         blue  = rd_data[index + 1]  ;
         green = rd_data[index + 2]  ;    
        S_AXIS_tdata  <= {{5{8'b0000_0000}},{red},{blue},{green}};
    #2;
    end
    
 // $finish();
    //////////////////////////////////////////////////////////////////传入weight至buff///////////////////////////////////////////
     S_AXIS_tlast  <= 1'b0;
     S_AXIS_tvalid <= 0;   M_AXIS_tready = 1'b1;
     #2;
            
            rst     = 1;
            #20 rst     = 0;  
            
   
        S_AXI_LITE_CTRL_awaddr = 5'h00;
        S_AXI_LITE_CTRL_wdata  = 32'hfff0_0105;
        //test write logic
//        while(S_AXI_LITE_CTRL_awaddr <= 5'h0c)

            S_AXI_LITE_CTRL_awvalid = 1'b1;
            S_AXI_LITE_CTRL_wvalid  =  1'b1;
            #4
            S_AXI_LITE_CTRL_awvalid = 1'b0;
            S_AXI_LITE_CTRL_wvalid  = 1'b0;
            #2
            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata;
            
            #10;

            M_AXIS_tready = 1'b1;
             S_AXIS_tvalid <= 1;
            
    for (index = 54; index < 4151; index = index + 1) begin
        num = num ;
        
        S_AXIS_tdata  <={ 8{num}};
    #2;
    end
   // $finish();
    //////////////////////////////////////////////////////////////////传入bias至buff///////////////////////////////////////////
     S_AXIS_tlast  <= 1'b0;
     S_AXIS_tvalid <= 0;   M_AXIS_tready = 1'b1;
     #2;
            
            rst     = 1;
            #20 rst     = 0;  
            
   
        S_AXI_LITE_CTRL_awaddr = 5'h00;
        S_AXI_LITE_CTRL_wdata  = 32'hfff0_010d;
        //test write logic
//        while(S_AXI_LITE_CTRL_awaddr <= 5'h0c)

            S_AXI_LITE_CTRL_awvalid = 1'b1;
            S_AXI_LITE_CTRL_wvalid  =  1'b1;
            #4
            S_AXI_LITE_CTRL_awvalid = 1'b0;
            S_AXI_LITE_CTRL_wvalid  = 1'b0;
            #2
            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata;
            
            #10;


    M_AXIS_tready = 1'b1;
    S_AXIS_tvalid <= 1;
    for (index = 54; index < 4151; index = index + 1) begin
        num1 = num1 + 1'b1;
        
        S_AXIS_tdata  <= num1;
    #2;
   end 
    ///开始卷积
    // $finish();
        S_AXI_LITE_CTRL_awaddr = 5'h00;
        S_AXI_LITE_CTRL_wdata  = 32'hfff4_0058;//fff0_0058  进行1x1卷积     fff4_0058     进行3x3卷积
        //test write logic
//        while(S_AXI_LITE_CTRL_awaddr <= 5'h0c)

            S_AXI_LITE_CTRL_awvalid = 1'b1;
            S_AXI_LITE_CTRL_wvalid  =  1'b1;
            #4
            S_AXI_LITE_CTRL_awvalid = 1'b0;
            S_AXI_LITE_CTRL_wvalid  = 1'b0;
            #2
            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata;
            
            #10;
    
   
    
    
    
    end






    
 
    


// always @(posedge clk) begin 
//            if(rst) begin
//                S_AXIS_tdata  <= 0;
//                S_AXIS_tlast  <= 1'b0;
//                S_AXIS_tvalid <= 0;
//            end else begin
//                S_AXIS_tvalid <= 1;

//            end
//            if (S_AXIS_tdata=='d63)
//                S_AXIS_tlast  <= 1'b1;
//            else
//                S_AXIS_tlast  <= 1'b0;
          
//        end

//always @(posedge clk) begin 
// if((S_AXIS_tdata!='d64)&(S_AXIS_tvalid == 1'b1))
//                    S_AXIS_tdata <= S_AXIS_tdata+1'b1;
// else 
//                    S_AXIS_tdata <= 1'b0;

//end





    
///////////axi_lite
   initial begin
           rst     = 1;
        #2 rst     = 0;
//        S_AXI_LITE_CTRL_awaddr = 5'h00;
//        S_AXI_LITE_CTRL_wdata  = 32'hffff_f9f3;
//        //test write logic
//        while(S_AXI_LITE_CTRL_awaddr <= 5'h0c)
//        begin
//            S_AXI_LITE_CTRL_awvalid = 1'b1;
//            S_AXI_LITE_CTRL_wvalid  =  1'b1;
//            #4
//            S_AXI_LITE_CTRL_awvalid = 1'b0;
//            S_AXI_LITE_CTRL_wvalid  = 1'b0;
//            #2
//            S_AXI_LITE_CTRL_awaddr  = S_AXI_LITE_CTRL_awaddr+5'h4;
//            S_AXI_LITE_CTRL_wdata   = S_AXI_LITE_CTRL_wdata+1;
//        end
        //test read logic
        S_AXI_LITE_CTRL_araddr = 5'h00;
        while(S_AXI_LITE_CTRL_araddr <= 5'h0c)
        begin
            S_AXI_LITE_CTRL_arvalid = 1'b1;
            #4
            S_AXI_LITE_CTRL_arvalid = 1'b0;
            #2
            S_AXI_LITE_CTRL_araddr  = S_AXI_LITE_CTRL_araddr+5'h4;
        end
    end

///////////////////////////////////////////////
	always #1 clk = ~clk;//生成时钟

/////////////////////////////////////////////////	
	
Accel_Conv #() u_Accel_Conv
(

. clk                 (clk              )               ,                                                        
. rst                 (rst              )               ,                                                       
. ap_done             (ap_done          )               ,   
	//写地址
. S_AXI_LITE_CTRL_awaddr         ( S_AXI_LITE_CTRL_awaddr    )               , 
. S_AXI_LITE_CTRL_awprot         ( S_AXI_LITE_CTRL_awprot    )               , // 杈撳叆琛屼俊鍙?                                    
. S_AXI_LITE_CTRL_awvalid        ( S_AXI_LITE_CTRL_awvalid   )               ,         // 杈撳嚭鐗瑰緛鍥撅紙OFM锛夊彂閫侀?夋嫨淇″彿                
. S_AXI_LITE_CTRL_awready        ( S_AXI_LITE_CTRL_awready   )               ,
//写数据
. S_AXI_LITE_CTRL_wdata          (S_AXI_LITE_CTRL_wdata )                                          ,
. S_AXI_LITE_CTRL_wstrb          (S_AXI_LITE_CTRL_wstrb )                                          ,
. S_AXI_LITE_CTRL_wvalid         (S_AXI_LITE_CTRL_wvalid)                                          ,
. S_AXI_LITE_CTRL_wready         (S_AXI_LITE_CTRL_wready)                                          ,
//写应答信号
. S_AXI_LITE_CTRL_bresp           (S_AXI_LITE_CTRL_bresp  ),
. S_AXI_LITE_CTRL_bvalid          (S_AXI_LITE_CTRL_bvalid ),
. S_AXI_LITE_CTRL_bready          (S_AXI_LITE_CTRL_bready ),
//读地址
. S_AXI_LITE_CTRL_araddr          (S_AXI_LITE_CTRL_araddr ),
. S_AXI_LITE_CTRL_arprot          (S_AXI_LITE_CTRL_arprot ),
. S_AXI_LITE_CTRL_arvalid         (S_AXI_LITE_CTRL_arvalid),
. S_AXI_LITE_CTRL_arready         (S_AXI_LITE_CTRL_arready),
//读数据
. S_AXI_LITE_CTRL_rdata          (S_AXI_LITE_CTRL_rdata  ),
. S_AXI_LITE_CTRL_rresp          (S_AXI_LITE_CTRL_rresp  ),
. S_AXI_LITE_CTRL_rvalid         (S_AXI_LITE_CTRL_rvalid ),
. S_AXI_LITE_CTRL_rready         (S_AXI_LITE_CTRL_rready ),

// axi-stream slave interface
. S_AXIS_tready                  ( S_AXIS_tready ),
. S_AXIS_tdata                   ( S_AXIS_tdata  ),
. S_AXIS_tlast                   ( S_AXIS_tlast  ),
. S_AXIS_tvalid                  ( S_AXIS_tvalid ),

// axi-stream master interface
. M_AXIS_tvalid                   (M_AXIS_tvalid  ),
. M_AXIS_tdata                    (M_AXIS_tdata   ),
. M_AXIS_tlast                    (M_AXIS_tlast   ),
. M_AXIS_tready                   (M_AXIS_tready  )


	
    );
endmodule
