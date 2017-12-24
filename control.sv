//module outputs to OCMframebuffer the correct pixel data
//to be written in
//decodes the pixel data being sent back from OCMframebuffer
//and translates it into RGB values to send to VGA controller

module color_LUT(
					//handling data that goes into OCMframebuffer
					output [1:0] data_out,
					//pass in switches data to change color
					input [1:0]color_SW,
					
					//pass in whether pixel is laser cursor
					input isBall,
					input isColorPalette,
					input isColorPaletteBorder,
					
					//handling data that is coming out of OCMframebuffer
					input [1:0] data_read,
					output [9:0] VGA_R,
					output [9:0] VGA_G,
					output [9:0] VGA_B
					
);


//handles writing data into OCMframebuffer
assign data_out = color_SW;


//handles reading data out of OCMframebuffer
always_comb begin
	if(isBall) begin
		VGA_R = 10'h00;
		VGA_G = 10'b1111111111;
		VGA_B = 10'h00;
	end
	else if (isColorPalette == 1'd1) begin
		case (color_SW)
		2'b00: begin				//white
					VGA_R = 10'b1111111111;
					VGA_G = 10'b1111111111;
					VGA_B = 10'b1111111111;
				 end
		2'b01: begin				//black
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		2'b10: begin				//red
					VGA_R = 10'b1111111111;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		2'b11: begin				//blue
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'b1111111111;
				 end
		default: begin				//black
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		endcase
	end
	else if (isColorPaletteBorder == 1'd1) begin
		VGA_R = 10'h00;
		VGA_G = 10'h00;
		VGA_B = 10'h00;
	end
	else begin
		case (data_read)
		2'b00: begin				//white
					VGA_R = 10'b1111111111;
					VGA_G = 10'b1111111111;
					VGA_B = 10'b1111111111;
				 end
		2'b01: begin				//black
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		2'b10: begin				//red
					VGA_R = 10'b1111111111;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		2'b11: begin				//blue
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'b1111111111;
				 end
		default: begin				//black
					VGA_R = 10'h00;
					VGA_G = 10'h00;
					VGA_B = 10'h00;
				 end
		endcase
	end
end



endmodule



