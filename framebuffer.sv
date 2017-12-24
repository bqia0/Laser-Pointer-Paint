module frameBuffer(	input VGAClk,
					input SRAMClk,
					input Reset,
					//VGA blanking interval signal
					//pixels are only being written into SRAM frameBuffer
					//during the blanking interval
					input VGA_BLANK_N,

					//inputs for dot being written into FrameBuffer
					input red[9:0],
						  green,
						  blue,
					input [9:0]Dot_X,
					input [9:0]Dot_Y,
					//boolean input specifying whether to draw
					//a pixel into SRAM framebuffer
					input drawDot,

					//input for VGA coordinates being drawn
					//(coordinates of pixel that needs to be read from SRAM)
					input [9:0]VGA_X,
					input [9:0]VGA_Y,
					
					//data being read from SRAM
					 input dataIn[15:0],	  
				    output writeEnable_n,
				    output readEnable_n,
					//address passed to SRAM
				    output address[17:0],
					//data to write to SRAM
				    output dataOut[15:0]
				    );

//internal logic storing which pixel is being read/written				    
logic x, y;
logic xNext, yNext;
parameter [9:0] H_TOTAL = 10'd800;
parameter [9:0] V_TOTAL = 10'd525;

always_ff @ (posedge SRAMClk)
begin
	x = 0; 
	y = 0;
	writeEnable_n = 1'b1;
	readEnable_n = 1'b1;
	address = 0;
	dataOut = 0;

	//draw frameBuffer into SRAM when VGA is blank
	if(VGA_BLANK_N)
	begin
		writeEnable_n = 1'b0;
		address = y * 800 + x;

		//write in Dot RGB values if Draw_Dot, else just 
		if (drawDot && x == Dot_X && y == Dot_Y)
			begin
				dataOut = {1'b1, red[9:5], green[9:5], blue[9:5]}; 
			end
		else
			begin
				dataOut = dataIn;
			end

		x = xNext;
		y = yNext; 

	end	

end


always_ff @ (posedge VGAClk)
begin
	x = 0; 
	y = 0;
	writeEnable_n = 1'b1;
	readEnable_n = 1'b1;
	address = 0;
	dataOut = 0;	
	if(~VGA_BLANK_N)
	begin
		readEnable_n = 1'b0;
		address = y * 800 + x;
		x = VGA_X;
		y = VGA_Y;
	end	
end



always_comb
begin
	xNext = x + 10'd1;
	yNext = y;
    if(x + 10'd1 == H_TOTAL)
    begin
        xNext = 10'd0;
        if(y + 10'd1 == V_TOTAL)
            yNext = 10'd0;
        else
            yNext = y + 10'd1;
    end
end

endmodule
