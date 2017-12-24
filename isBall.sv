module isBall(input [10:0] xLaser,
						   yLaser,
			  input [9:0] VGA_X, 
						  VGA_Y,
						  
			  input Clk,
			  input Reset,
			  output 	 isBall);
			  
			  
			  
parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_Size=2;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = VGA_X - Ball_X_Pos;
    assign DistY = VGA_Y - Ball_Y_Pos;
    assign Size = Ball_Size;
    
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;

        end
        else if (Clk)        // Update only at rising edge of frame clock
        begin

            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;				

        end
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
		  Ball_Y_Pos_in = yLaser[10:1];
		  Ball_X_Pos_in = xLaser[10:1];
		  
    end
always_comb
begin
        // Compute whether the pixel corresponds to ball or background
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            isBall = 1'b1;
        else
            isBall = 1'b0;
end	 
    
endmodule