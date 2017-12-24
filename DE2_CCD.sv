// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2 CMOS Camera Demo
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 06/01/06  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 06/02/06  :|      Modify Image Quality
//   V1.2 :| Johnny Chen       :| 06/03/22  :|      Change Pin Assignment For New Sensor
//   V1.3 :| Johnny Chen       :| 06/03/22  :|      Fixed to Compatible with Quartus II 6.0
// --------------------------------------------------------------------

module DE2_CCD
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]

		/////////////////////	SDRAM Interface		////////////////		
		DRAM_ADDR, // DE2-115 SDRAM
		DRAM_BA,
		DRAM_CAS_N,
		DRAM_CKE,
		DRAM_CLK,
		DRAM_CS_N,
		DRAM_DQ,
		DRAM_DQM,
		DRAM_RAS_N,
		DRAM_WE_N,
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////

		////////////////////	GPIO	////////////////////////////
		GPIO,							//	GPIO Connection 0
		
		////////////////// SRAM ///////////////////////
		SRAM_DQ,
		SRAM_ADDR,
		SRAM_WE_N,
		SRAM_OE_N,
		SRAM_UB_N,
		SRAM_LB_N,
		SRAM_CE_N
		
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digitra4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]

output		    [12:0]		DRAM_ADDR; // DE2-115 SDRAM
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout		    [31:0]		DRAM_DQ;
output		     [3:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK_N;				//	VGA BLANK
output			VGA_SYNC_N;				//	VGA SYNC
output	[7:0]	VGA_R;   				//	VGA Red[9:0]
output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
output	[7:0]	VGA_B;   				//	VGA Blue[9:0]



inout	[35:0]	GPIO;					//	GPIO Connection 0


////////////////// SRAM ///////////////////////
inout		[15:0]SRAM_DQ;
output	[17:0]SRAM_ADDR;
output			SRAM_WE_N;
output			SRAM_OE_N;
output			SRAM_UB_N;
output			SRAM_LB_N;
output			SRAM_CE_N;


//internal variables
logic		[15:0]Data_from_SRAM;



assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;
assign	TD_RESET	=	1'b1;

//	All inout port turn to tri-state
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	LCD_DATA	=	8'hzz;
assign	SD_DAT		=	1'bz;
assign	I2C_SDAT	=	1'bz;


//	CCD
wire	[9:0]	CCD_DATA;
wire			CCD_SDAT;
wire			CCD_SCLK;
wire			CCD_FLASH;
wire			CCD_FVAL;
wire			CCD_LVAL;
wire			CCD_PIXCLK;
reg				CCD_MCLK;	//	CCD Master Clock

wire	[15:0]	Read_DATA1;
wire	[15:0]	Read_DATA2;
wire  [31:0]	Read_DATA_NEW;
wire			VGA_CTRL_CLK;
wire			AUD_CTRL_CLK;
wire	[9:0]	mCCD_DATA;
wire			mCCD_DVAL;
wire			mCCD_DVAL_d;
wire	[10:0]	X_Cont;
wire	[10:0]	Y_Cont;
wire	[9:0]	X_ADDR;
wire	[31:0]	Frame_Cont;
wire	[9:0]	mCCD_R;
wire	[9:0]	mCCD_G;
wire	[9:0]	mCCD_B;
wire			DLY_RST_0;
wire			DLY_RST_1;
wire			DLY_RST_2;
wire			Read;
reg		[9:0]	rCCD_DATA;
reg				rCCD_LVAL;
reg				rCCD_FVAL;
wire	[9:0]	sCCD_R;
wire	[9:0]	sCCD_G;
wire	[9:0]	sCCD_B;
wire			sCCD_DVAL;



// Debugging logic
reg  [7:0] VGA_Green_Center;
wire [9:0] VGA_X;
wire [9:0] VGA_Y;
wire [7:0] VGA_Green_Wire;
wire [9:0] VGA_G_wire1;
wire [9:0] VGA_R_wire1;
wire [9:0] VGA_B_wire1;
wire [7:0] VGA_G_wire2;
wire [7:0] VGA_R_wire2;
wire [7:0] VGA_B_wire2;

logic [9:0] posX;
logic [9:0] posY;

wire [9:0] mCCD_R2;
wire [9:0] mCCD_G2;
wire [9:0] mCCD_B2;







//	For Sensor 1
assign	CCD_DATA[0]	=	GPIO[0];
assign	CCD_DATA[1]	=	GPIO[1];
assign	CCD_DATA[4]	=	GPIO[2];
assign	CCD_DATA[3]	=	GPIO[3];
assign	CCD_DATA[5]	=	GPIO[4];
assign	CCD_DATA[2]	=	GPIO[5];
assign	CCD_DATA[6]	=	GPIO[6];
assign	CCD_DATA[7]	=	GPIO[7];
assign	CCD_DATA[8]	=	GPIO[8];
assign	CCD_DATA[9]	=	GPIO[9];
assign	GPIO[11]	=	CCD_MCLK;
//assign	GPIO[15]	=	CCD_SDAT;
//assign	GPIO[14]	=	CCD_SCLK;
assign	CCD_FVAL	=	GPIO[13];
assign	CCD_LVAL	=	GPIO[12];
assign	CCD_PIXCLK	=	GPIO[10];

//assign	LEDR		=	CCD_DATA;
//assign	LEDG		=	Y_Cont;
assign	VGA_CTRL_CLK=	CCD_MCLK;
assign	VGA_CLK		=	~CCD_MCLK;



always@(posedge CLOCK_50)	CCD_MCLK	<=	~CCD_MCLK; // This makes a 25 MHz clock

always@(posedge CCD_PIXCLK)
begin
	rCCD_DATA	<=	CCD_DATA;
	rCCD_LVAL	<=	CCD_LVAL;
	rCCD_FVAL	<=	CCD_FVAL;
end

//0 is for writing from detection
//1 is for reading to color mapper
wire [3:0] enable;

logic run;
logic background;
assign background = SW[1];

logic clear;
assign clear = SW[17];

logic red_on;
assign red_on =  SW[9];

logic green_on;
assign green_on =  SW[10];

logic blue_on;
assign blue_on =  SW[11];

wire [18:0] address_0; 
logic [3:0] data_0;
wire cs_0;
wire we_0;
wire oe_0;
wire [18:0] address_1;
wire [3:0] data_1;
wire cs_1;
wire we_1;
wire oe_1;

logic [9:0] red;
logic [9:0] blue;
logic [9:0] green;
logic [10:0] X_laser;
logic[10:0]  Y_laser;
logic is_ball;
assign cs_0 = 1;
assign we_0 = 1;
assign oe_0 = 0;

assign cs_1 = 1;
assign we_1 = 0;
assign oe_1 = 1;


HexDriver	r0	(	.Out0(HEX7),.In0({3'b111, is_ball})	);
HexDriver	r1	(	.Out0(HEX6),.In0(X_laser[6:3])	);
HexDriver	r2	(	.Out0(HEX5),.In0({X_laser[2:0], 1'b0} )	);

HexDriver	g0	(	.Out0(HEX4),.In0(Y_laser[10:7])	);
HexDriver	g1	(	.Out0(HEX3),.In0(Y_laser[6:3])	);
HexDriver	g2	(	.Out0(HEX2),.In0({Y_laser[2:0], 1'b0})	);

assign LEDR[10:0] = red;



Detection d1 (.Rin(sCCD_R), .Gin(sCCD_G), .Bin(sCCD_B), .Rout(mCCD_R2), .Gout(mCCD_G2), .Bout(mCCD_B2), 
	.CLK(CLOCK_50), 
	.X(X_Cont), .Y(Y_Cont), .VGA_VS(VGA_VS), .Reset(!DLY_RST_2) ,
	.run(run), .Xlaser(X_laser), .Ylaser(Y_laser), .SW(SW)
		);


//Color_Mapper c1(.VGA_R_In(Read_DATA2[9:0]), .VGA_G_In({Read_DATA1[14:10],Read_DATA2[14:10]}), .VGA_B_In(Read_DATA1[9:0]),
//					 .VGA_X(VGA_X), .VGA_Y(VGA_Y), 
//					 .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .CLK(VGA_CTRL_CLK), .is_ball(is_ball) 
//					 );
					 
ball ball_instance(.Clk(CLOCK_50), .Reset(~KEY[0]), .frame_clk(VGA_VS), .DrawX(VGA_X), .DrawY(VGA_Y), .is_ball(is_ball), .X_laser(X_laser), .Y_laser(Y_laser));		
			 
State_Control sc1(.clk(CLOCK_50), .reset_n(KEY[0]), .get_color(~KEY[2]), .run(run));

//VGA_Controller		u1	(	
//							.oRequest(Read),
//							.iRed(Read_DATA2[9:0]),
//							.iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}),
//							.iBlue(Read_DATA1[9:0]),						
//							.oVGA_R(VGA_R_wire1),
//							.oVGA_G(VGA_G_wire1),
//							.oVGA_B(VGA_B_wire1),
						//	.oVGA_H_SYNC(VGA_HS),
						//	.oVGA_V_SYNC(VGA_VS),
						//	.oVGA_SYNC(VGA_SYNC_N),
						//	.oVGA_BLANK(VGA_BLANK_N),
//							.iCLK(VGA_CTRL_CLK),
//							.iRST_N(DLY_RST_2)
						//	.VGA_X(VGA_X),
						//	.VGA_Y(VGA_Y)
//										);



VGA_controller v1(.Clk(CLOCK_50),         // 50 MHz clock
                  .Reset(~KEY[0]),       // Active-high reset signal
                  .VGA_HS(VGA_HS),      // Horizontal sync pulse.  Active low
                  .VGA_VS(VGA_VS),      // Vertical sync pulse.  Active low
                  .VGA_CLK(VGA_CLK),     // 25 MHz VGA clock input
                  .VGA_BLANK_N(VGA_BLANK_N), // Blanking interval indicator.  Active low.
                  .VGA_SYNC_N(VGA_SYNC_N),  // Composite Sync signal.  Active low.  We don't use it in this lab,
                  .DrawX(VGA_X),       // horizontal coordinate
                  .DrawY(VGA_Y)        // vertical coordinate
                        );   

Reset_Delay			u2	(	.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY_RST_0),
							.oRST_1(DLY_RST_1),
							.oRST_2(DLY_RST_2)	);

CCD_Capture			u3	(	.oDATA(mCCD_DATA),
							.oDVAL(mCCD_DVAL),
							.oX_Cont(X_Cont),
							.oY_Cont(Y_Cont),
							.oFrame_Cont(Frame_Cont),
							.iDATA(rCCD_DATA),
							.iFVAL(rCCD_FVAL),
							.iLVAL(rCCD_LVAL),
							.iSTART(!KEY[3]),
							.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_1)	);

RAW2RGB				u4	(	.oRed(mCCD_R),
							.oGreen(mCCD_G),
							.oBlue(mCCD_B),
							.oDVAL(mCCD_DVAL_d),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_1)	);
							


Sdram_Control_4Port	u6	(	//	HOST Side
						    .REF_CLK(CLOCK_50),
						    .RESET_N(1'b1),
						    .WR1_DATA(	{mCCD_G2[9:5],
										 mCCD_B2[9:0]}),
							.WR1(mCCD_DVAL_d),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(640*512),
							.WR1_LENGTH(9'h100),
							.WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(CCD_PIXCLK),
						    .WR2_DATA(	{mCCD_G2[4:0],
										 mCCD_R2[9:0]}),
							.WR2(mCCD_DVAL_d),
							.WR2_ADDR(22'h100000),
							.WR2_MAX_ADDR(22'h100000+640*512),
							.WR2_LENGTH(9'h100),
							.WR2_LOAD(!DLY_RST_0),
							.WR2_CLK(CCD_PIXCLK),
						    .RD1_DATA(Read_DATA1),
				        	.RD1(Read),
				        	.RD1_ADDR(640*16),
							.RD1_MAX_ADDR(640*496),
							.RD1_LENGTH(9'h100),
				        	.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(VGA_CTRL_CLK),
						    .RD2_DATA(Read_DATA2),
				        	.RD2(Read),
				        	.RD2_ADDR(22'h100000+640*16),
							.RD2_MAX_ADDR(22'h100000+640*496),
							.RD2_LENGTH(9'h100),
				        	.RD2_LOAD(!DLY_RST_0),
							.RD2_CLK(VGA_CTRL_CLK),
						    .SA(DRAM_ADDR),
						    .BA(DRAM_BA),
						    .CS_N(DRAM_CS_N),
						    .CKE(DRAM_CKE),
						    .RAS_N(DRAM_RAS_N),
				            .CAS_N(DRAM_CAS_N),
				            .WE_N(DRAM_WE_N),
						    .DQ(DRAM_DQ),
				            .DQM({DRAM_DQM[1],DRAM_DQM[0]}),
							.SDR_CLK(DRAM_CLK)	);
						


I2C_CCD_Config 		u7	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(KEY[1]),
							.iExposure(SW[15:0]),
							.I2C_SCLK(GPIO[14]),
							.I2C_SDAT(GPIO[15])	);

Mirror_Col			u8	(	//	Input Side
							.iCCD_R(mCCD_R),
							.iCCD_G(mCCD_G),
							.iCCD_B(mCCD_B),
							.iCCD_DVAL(mCCD_DVAL_d),
							.iCCD_PIXCLK(CCD_PIXCLK),
							.iRST_N(DLY_RST_1),
							.oCCD_R(sCCD_R),
							.oCCD_G(sCCD_G),
							.oCCD_B(sCCD_B),
							.oCCD_DVAL(sCCD_DVAL));
							
							
							
color_LUT	color1(	
					//handling data that goes into OCMframebuffer
					//pass in switches data to change color
					.color_SW(SW[17:16]),
					.data_out(frameBufferIn),
					
					.isBall(isBall),
					.isColorPalette(isColorPalette),
					.isColorPaletteBorder(isColorPaletteBorder),
					
					//handling data that is coming out of OCMframebuffer
					.data_read(frameBufferOut),
					.VGA_R(VGA_R),
					.VGA_G(VGA_G),
					.VGA_B(VGA_B)
					
);

logic [1:0] frameBufferIn;
logic [1:0] frameBufferOut;
logic isBall;
logic isColorPalette;
logic isColorPaletteBorder;

OCMframebuffer OCMfb1(		//pixel data, color data, and coordinates data
								.data_In(frameBufferIn),
								.x_draw(X_laser),.y_draw(Y_laser),
								.drawDot(~KEY[2]),
								
								//coordinates for pixel to be read out of frameBuffer
								.x_read(VGA_X),.y_read(VGA_Y),
								
								
								.VGA_Clk(VGA_CLK), .Clk(CLOCK_50),
								.fastClock(CLOCK_100),
								.reset(~KEY[3]),

								
								
								//outputs pixel color data for the specified pixel to be read
								//out of frameBuffer
								.data_Out(frameBufferOut),
								.isBall(isBall),
								.isColorPalette(isColorPalette),
								.isColorPaletteBorder(isColorPaletteBorder)
);
logic CLOCK_100;					
pll fast (.inclk0(CLOCK_50),		
			 .c0(CLOCK_100)	);			
			
//// send RGB values (5 bits) into SRAM
//Mem2IO memory_subsystem(
//    .*, .Reset(Reset_ah), .ADDR(),
//    .Data_from_CPU({1'b1,VGA_R[7:3],VGA_G[7:3],VGA_B[7:3]}), .Data_to_CPU(RGB_OUT),
//    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)			//these two lines connect to tristate buffer
//);


// The tri-state buffer serves as the interface between Mem2IO and SRAM
//NEED TO FIGURE OUT WHAT IS TRSTATE_OUTPUT_ENABLE
//tristate #(.N(16)) tr0(
//    .Clk(Clk), .tristate_output_enable(~WE_S),
//	 .Data_write({1'b1,sCCD_R[7:3],sCCD_G[7:3],sCCD_B[7:3]}),
//	 .Data_read(Data_from_SRAM), .Data(SRAM_DQ)
//);



endmodule
						
