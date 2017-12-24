//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [10:0]  X_laser, Y_laser,
					input [7:0]	  keycode,
               output logic  is_ball             // Whether current pixel belongs to ball or background
              );
    
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
    parameter [9:0] Ball_Size=4;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = Ball_Size;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed;
    logic frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
    end
    assign frame_clk_rising_edge = (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    // Update ball position and motion
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;

        end
        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
            //Ball_X_Pos <= X_laser[10:1];
            //Ball_Y_Pos <= Y_laser[10:1];
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;				
            //Ball_X_Motion <= Ball_X_Motion_in;
            //Ball_Y_Motion <= Ball_Y_Motion_in;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
        // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
		  Ball_Y_Pos_in = Y_laser[10:1];
		  Ball_X_Pos_in = X_laser[10:1];
		  /*
        if( Y_laser[10:0] + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
				begin
            Ball_Y_Pos_in = Ball_Y_Pos;
		      Ball_X_Pos_in = Ball_X_Pos;  
				end
        else if ( Y_laser[10:0] <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
            begin
            Ball_Y_Pos_in = Ball_Y_Pos;
		      Ball_X_Pos_in = Ball_X_Pos;				
				end
				
		  if (X_laser[10:0]  <= Ball_X_Min + Ball_Size) //left edge
            begin
            Ball_Y_Pos_in = Ball_Y_Pos;
		      Ball_X_Pos_in = Ball_X_Pos;				
				end	
		  else if (X_laser[10:0] + Ball_Size >= Ball_X_Max)  //right edge
            begin
            Ball_Y_Pos_in = Ball_Y_Pos;
		      Ball_X_Pos_in = Ball_X_Pos;				
				end
        */
    end
always_comb
begin
        // Compute whether the pixel corresponds to ball or background
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
end	 
    
endmodule
