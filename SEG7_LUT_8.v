module SEG7_LUT_8 (	oSEG0,oSEG1,oSEG2,oSEG3,oSEG4,oSEG5,oSEG6,oSEG7,i1, i2);
input	[31:0]	i1;
input	[31:0]	i2;
output	[6:0]	oSEG0,oSEG1,oSEG2,oSEG3,oSEG4,oSEG5,oSEG6,oSEG7;


SEG7_LUT	u0	(	oSEG0,i1[3:0]		);
SEG7_LUT	u1	(	oSEG1,i1[7:4]		);
SEG7_LUT	u2	(	oSEG2,i1[11:8]	);
SEG7_LUT	u3	(	oSEG3,i1[15:12]	);
SEG7_LUT	u4	(	oSEG4,i2[3:0]	);
SEG7_LUT	u5	(	oSEG5,i2[7:4]	);
SEG7_LUT	u6	(	oSEG6,i2[11:8]	);
SEG7_LUT	u7	(	oSEG7,i2[15:12]	);

//HexDriver	u6	(	.Out0(oSEG6),.In0(VGA_Green[3:0])	);
//HexDriver	u7	(	.Out0(oSEG7),.In0(VGA_Green[7:4])	);

endmodule