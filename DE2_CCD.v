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
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter
		IRDA_RXD,						//	IRDA Receiver
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
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	    TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock

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
		GPIO							//	GPIO Connection 0

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
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			IRDA_RXD;				//	IRDA Receiver

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

////////////////////////	Flash Interface	////////////////////////
inout	[7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output	[17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
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

wire [9:0] posX;
wire [9:0] posY;

wire [9:0] mCCD_R2;
wire [9:0] mCCD_G2;
wire [9:0] mCCD_B2;


int	xCount;
int	yCount;
int	frame;


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

// Debugging code
/*
always@(posedge VGA_CTRL_CLK)
begin
	if(VGA_X === 10'd464 && VGA_Y === 10'd274)
		begin
			VGA_Green_Center <= VGA_Green_Wire;
		end
end
*/
//HexDriver hex6(.Out0(HEX6), .In0(VGA_Green_Center[3:0]));
//HexDriver hex7(.Out0(HEX7), .In0(VGA_Green_Center[7:4]));

//RGBResampler r1(.VGA_R_In(VGA_R_wire1), .VGA_G_In(VGA_G_wire1), .VGA_B_In(VGA_B_wire1),
//					 .VGA_R_Out(VGA_R_wire2), .VGA_G_Out(VGA_G_wire2), .VGA_B_Out(VGA_B_wire2));

Detection d1 (.Rin(mCCD_R), .Gin(mCCD_G), .Bin(mCCD_B), .Rout(mCCD_R2), .Gout(mCCD_G2), .Bout(mCCD_B2), .SW(SW), .CLK(CCD_PIXCLK), 
.X(VGA_X), .Y(VGA_Y), .VGA_VS(VGA_VS), .posX(posX), .posY(posY), .xCount(xCount), .yCount(yCount), .frame(frame));

Color_Mapper c1(.VGA_R_In(VGA_R_wire1), .VGA_G_In(VGA_G_wire1), .VGA_B_In(VGA_B_wire1),
					 .VGA_X(VGA_X), .VGA_Y(VGA_Y), .posX(posX), .posY(posY),
					 .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

VGA_Controller		u1	(	//	Host Side
							.oRequest(Read),
							.iRed(Read_DATA2[9:0]),
							.iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}),
							.iBlue(Read_DATA1[9:0]),
							
							//.iRed(sCCD_R),
							//.iGreen(sCCD_G),
							//.iBlue(sCCD_B),
							//	VGA Side
							.oVGA_R(VGA_R_wire1),
							.oVGA_G(VGA_G_wire1),
							.oVGA_B(VGA_B_wire1),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC_N),
							.oVGA_BLANK(VGA_BLANK_N),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2),
							.VGA_X(VGA_X),
							.VGA_Y(VGA_Y)
							//.VGA_G2(VGA_Green_Wire)
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
							.iEND(!KEY[2]),
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
							/*

SEG7_LUT_8 			u5	(	.oSEG0(HEX0),.oSEG1(HEX1),
							.oSEG2(HEX2),.oSEG3(HEX3),
							.oSEG4(HEX4),.oSEG5(HEX5),
							.oSEG6(HEX6),.oSEG7(HEX7),
							.i1(VGA_X), .i2(VGA_Y)
							);
							*/

Sdram_Control_4Port	u6	(	//	HOST Side
						    .REF_CLK(CLOCK_50),
						    .RESET_N(1'b1),
							//	FIFO Write Side 1
						    .WR1_DATA(	{mCCD_G2[9:5],
										 mCCD_B2[9:0]}),
							.WR1(mCCD_DVAL_d),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(640*512),
							.WR1_LENGTH(9'h100),
							.WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(CCD_PIXCLK),
							//	FIFO Write Side 2
						    .WR2_DATA(	{mCCD_G2[4:0],
										 mCCD_R2[9:0]}),
							.WR2(mCCD_DVAL_d),
							.WR2_ADDR(22'h100000),
							.WR2_MAX_ADDR(22'h100000+640*512),
							.WR2_LENGTH(9'h100),
							.WR2_LOAD(!DLY_RST_0),
							.WR2_CLK(CCD_PIXCLK),
							//	FIFO Read Side 1
						    .RD1_DATA(Read_DATA1),
				        	.RD1(Read),
				        	.RD1_ADDR(640*16),
							.RD1_MAX_ADDR(640*496),
							.RD1_LENGTH(9'h100),
				        	.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(VGA_CTRL_CLK),
							//	FIFO Read Side 2
						    .RD2_DATA(Read_DATA2),
				        	.RD2(Read),
				        	.RD2_ADDR(22'h100000+640*16),
							.RD2_MAX_ADDR(22'h100000+640*496),
							.RD2_LENGTH(9'h100),
				        	.RD2_LOAD(!DLY_RST_0),
							.RD2_CLK(VGA_CTRL_CLK),
							//	SDRAM Side
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
							//	I2C Side
							.I2C_SCLK(GPIO[14]),
							.I2C_SDAT(GPIO[15])	);

Mirror_Col			u8	(	//	Input Side
							.iCCD_R(mCCD_R),
							.iCCD_G(mCCD_G),
							.iCCD_B(mCCD_B),
							.iCCD_DVAL(mCCD_DVAL_d),
							.iCCD_PIXCLK(CCD_PIXCLK),
							.iRST_N(DLY_RST_1),
							//	Output Side
							.oCCD_R(sCCD_R),
							.oCCD_G(sCCD_G),
							.oCCD_B(sCCD_B),
							.oCCD_DVAL(sCCD_DVAL));

endmodule
						
