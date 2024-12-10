module buffer_ofm
#(
	parameter DEPTH=114*114,
	parameter ADDR_BIT=12,
	parameter RAM_STYLE_VAL="block"
)
(
	input clk,
	input [ADDR_BIT-1:0] bram_write_addr,
	input bram_en_write,
	
	input int_sel,
	input [ADDR_BIT-1:0] bram_read_addr,
	input [63:0] ofm_store_bundle,
//	input [31:0] ofm_store4_bundle,
//	output [31:0] ofm_out4_bundle,
	output [63:0] ofm_out_bundle
);

//    wire [63:0] ofm_store48_bundle;
//    assign  ofm_store48_bundle = (int_sel) ? ofm_store_bundle : ofm_store4_bundle ;
    
//    assign ofm_out4_bundle = {ofm_out_bundle[59:56],ofm_out_bundle[51:48],ofm_out_bundle[43:40],ofm_out_bundle[35:32],ofm_out_bundle[27:24],ofm_out_bundle[19:16],ofm_out_bundle[11:8],ofm_out_bundle[3:0]};
    
	com_simple_dual_port_ram
	#(
		.WIDTH(64),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH),
		.RAM_STYLE_VAL(RAM_STYLE_VAL)
	)
	u_com_simple_dual_port_ram
	(
		.clk(clk),
		.we_a(bram_en_write),
		.en_a(1'b1),
		.addr_a(bram_write_addr),
		.di_a(ofm_store_bundle),
		
		.addr_b(bram_read_addr),
		.dout_b(ofm_out_bundle)
	);
endmodule