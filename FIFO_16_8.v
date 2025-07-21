module FIFO_16_8 #(parameter width=8,
                             depth=16,
                             addr_size=4)
(input clk,rst,
input [width-1:0]data_in,
//input [addr_size-1:0]wr_addr,
input wr_en,
//input [addr_size-1:0]rd_addr,
input rd_en,
output reg[width-1:0]data_out,
output empty,full); 
	
integer i;
	
reg [addr_size:0]rd_p;
reg [addr_size:0]wr_p;

reg [width-1:0]FIFO[0:depth-1];

always@(posedge clk)
   begin
       if(rst)
		   begin
			   wr_p<=5'b0;
			  for(i=0;i<depth;i=i+1)
			     FIFO[i]<=0;
		    end
		else
		   begin
		     if(wr_en && !full)
			   begin
			   FIFO[wr_p]<=data_in;
				  wr_p=wr_p+1'b1;
			   end
	       end
	  end
	always@(posedge clk)
   begin
       if(rst)
		 begin
		   rd_p<=5'b0;
		    data_out<=8'b0;	
		end 
		else
		   begin
		     if(rd_en && !empty)
			   begin
			    data_out<=FIFO[rd_p];
				  rd_p=rd_p+1'b1;
			   end
	       end
		end
assign empty=(wr_p==rd_p)?1'b1:1'b0;
assign full=(wr_p==5'b10000 && rd_p==00000)?1'b1:1'b0;
endmodule
	   