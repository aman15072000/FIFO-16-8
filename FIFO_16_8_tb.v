module FIFO_16_8_tb();
parameter width=8;
parameter depth=16;
parameter addr_size=4;

reg clk,rst;
	reg [width-1:0]data_in;
//input [addr_size-1:0]wr_addr,
reg wr_en;
//input [addr_size-1:0]rd_addr,
reg rd_en;
wire [width-1:0]data_out;
wire empty,full;
//parameter CYCLE=10;
	
	//reg [addr_size:0]rd_p,wr_p;
//reg [addr_size:0]wr_p;

	FIFO_16_8 DUT(clk,rst,data_in,wr_en,rd_en,data_out,empty,full);
  
  /* always
    begin
	   #(CYCLE/2);
	    clk=1'b0;
	   #(CYCLE/2);
	    clk=~clk;
	end */
	initial
	     begin
		    clk=1'b0;
			 forever
			     #5 clk=~clk;
			end  
	// always #5 clk=~clk;
	
  task initialize;
    begin
	  //clk=1'b0;
	  rst=1'b0;
	  data_in=8'b0;
      //wr_addr=4'b0;
      wr_en=1'b0;
      //rd_addr=4'b0;
      rd_en=1'b0;
	  //{rst,data_in,wr_addr,wr_en,rd_addr,rd_en}=0;
	  end
	 endtask
	 
 task rst_in;
  begin
     @(negedge clk);
	   rst=1'b1;
	  @(negedge clk);
	   rst=1'b0;
  end
 endtask
 
	task write(input i, input [width-1:0]k);
  begin
     @(negedge clk);
	   wr_en=i;
	   //wr_addr=j;
	   data_in=k;
  end
 endtask
	
	task read(input l); // input [width-1:0]n);
  begin
     @(negedge clk);
	   rd_en=l;
	   //rd_addr=m;
	   //data_out=n;
  end
 endtask
 
 initial
   begin
     initialize;
	  #10;
	   rst_in;
		//#30;
	    write(1'b1,8'd101);
		 write(1'b1,8'd102);
		 write(1'b1,8'd103);
		 write(1'b1,8'd104);
		 write(1'b1,8'd105);
		 write(1'b1,8'd106);
		 write(1'b1,8'd107);
		 write(1'b1,8'd108);
		 write(1'b1,8'd109);
		 write(1'b1,8'd110);
		 write(1'b1,8'd111);
		 write(1'b1,8'd112);
		 write(1'b1,8'd113);
		 write(1'b1,8'd114);
		 write(1'b1,8'd115);
		 write(1'b1,8'd116);



	    //write(1'b0,8'd125);
		#40;
	   read(1'b1);
	   //read(1'b0);
		//rst_in;
		#60;
		//Load_input(1'b0);
		//Load_Data(1'b0,4'd5);
		//#50;
		rst_in;
	   write(1'b1,8'd160);
		write(1'b0,8'd160);
		#10;
		read(1'b1);
	   read(1'b0);
		//#10;
		//read(1'b1,4'd8);
	   //read(1'b0,4'd8);
	   #150 $finish;
	end
	
 initial
   begin
	   $monitor("values of clk=%b,rst=%b,data_in=%b,wr_en=%b,rd_en=%b,data_out=%b,empty=%b,full=%b", clk,rst,data_in,wr_en,rd_en,data_out,empty,full);
   end
endmodule