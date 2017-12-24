 
 
//module that contains OCM array to store frame pixels

module  OCMframebuffer
(		//pixel data, color data, and coordinates data
		input [1:0] data_In,
		input [10:0] x_draw,y_draw,
		input drawDot,
		
		//coordinates for pixel to be read out of frameBuffer
		input [9:0] x_read,y_read,
		
		

		input VGA_Clk, Clk, fastClock,
		input reset,

		
		
		//outputs pixel color data for the specified pixel to be read
		//out of frameBuffer
		output logic [1:0] data_Out,
		output logic isBall,
		output logic isColorPalette,
		output logic isColorPaletteBorder
);


//instantiate isBall module to keep track of laser pointer
isBall	(.xLaser(x_draw),
			 .yLaser(y_draw),
			  .VGA_X(x_read), 
			  .VGA_Y(y_read),
			  .Clk(Clk),
			  .Reset(reset),
			  .isBall(isBall));

// mem has width of 4 bits and a total of 400 addresses
logic [1:0] mem [0:419999];

logic [20:0] write_address;
logic [20:0] read_address;


//write at speed of 50MHz
always_ff @ (posedge fastClock) begin
	
//	if (reset) begin
//		for (int i =0; i <= 419999; i++) begin
//			mem[i][1:0] <= 2'b00;
//		end
//	end
	
	if (drawDot)
	begin
		mem[write_address] <= data_In;
	end
end


initial
begin
	 $readmemb("memory.txt", mem);
end

always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];


end

always_comb begin
	write_address = x_draw[10:1] + y_draw[10:1] * 10'd800;
	read_address = x_read + y_read * 10'd800;
	
	if(x_read >= 10'd5 && x_read <= 10'd85 && y_read >= 10'd395 && y_read <= 10'd475) begin
		isColorPalette = 1'd1;
	end
	else
	begin
	isColorPalette = 1'd0;
	end
	
	if(x_read >= 10'd5 && x_read <= 10'd85 && (y_read >= 10'd393 && y_read <= 10'd397 || y_read >= 10'd473 && y_read <= 10'd478)) begin
		isColorPaletteBorder = 1'd1;
	end
	else if((x_read >= 10'd3 && x_read <= 10'd7 || x_read >= 10'd83 && x_read<=10'd87) && y_read >= 10'd395 && y_read <= 10'd475) begin
		isColorPaletteBorder = 1'd1;
	end
	else
	begin
	isColorPaletteBorder = 1'd0;
	end
end

	
endmodule




