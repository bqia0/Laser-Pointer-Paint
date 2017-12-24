module Detection(
input [9:0] Rin,
input [9:0] Gin,
input [9:0] Bin,
input 		CLK,
input [10:0] X,
input [10:0] Y,
input	[17:0]	SW,
input VGA_VS,
input Reset,
input run,
output [9:0] Rout,
output [9:0] Gout,
output [9:0] Bout,
output [10:0] Xlaser,
				  Ylaser
);


logic [9:0] red;
logic [9:0] blue;
logic [9:0] green;
logic[9:0]  R_Threshold;
logic[9:0]  R_Threshold_Next;
logic[10:0]	X_laser_Next,
				Y_laser_Next,
				X_laser,
				Y_laser;
//logic[9:0] R_Min;
logic[9:0] R_Max;
//assign R_Max = SW[9:0];
//assign R_Min = SW[9:0];
always_ff@(posedge CLK)
begin
	R_Threshold = R_Threshold_Next;
	X_laser <= X_laser_Next;
	Y_laser <= Y_laser_Next;
	//if(run == 1'b0)
	//begin
		if(X == 11'd800 && Y == 11'd525)
		begin
			red <= Rin;
			blue <= Bin;
			green <= Gin;
			Xlaser <= X_laser;
			Ylaser <= Y_laser;
		end
	//end
end

always_comb
begin				
			Rout = Rin;
			Gout = Gin;
			Bout = Bin;
end
always_comb
begin
	R_Threshold_Next = R_Threshold;
	X_laser_Next = X_laser;
	Y_laser_Next = Y_laser;
	if(X == 0 && Y == 0)
		begin
			R_Threshold_Next = 10'd0;
		end
	else
	begin
		if(Rin > R_Threshold && Rin > 10'd750)
			begin
			R_Threshold_Next = Rin;
			X_laser_Next = X;
			Y_laser_Next = Y;
			end
	end
end

endmodule	
