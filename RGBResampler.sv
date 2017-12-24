module RGBResampler(
	input        [9:0] VGA_R_In, VGA_G_In, VGA_B_In,
	output		 [7:0] VGA_R_Out, VGA_G_Out, VGA_B_Out
);

logic [19:0] VGA_R, VGA_G, VGA_B;

always_comb
begin
VGA_R = (VGA_R_In*10'd255);
VGA_R_Out = (VGA_R/10'd1024);
end

always_comb
begin
VGA_G = (VGA_G_In*10'd255);
VGA_G_Out = (VGA_G/10'd1024);
end

always_comb
begin
VGA_B = (VGA_B_In*10'd255);
VGA_B_Out = (VGA_B/10'd1024);
end


endmodule