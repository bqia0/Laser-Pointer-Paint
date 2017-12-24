	nios_system u0 (
		.clk_clk                                              (<connected-to-clk_clk>),                                              //                                      clk.clk
		.reset_reset_n                                        (<connected-to-reset_reset_n>),                                        //                                    reset.reset_n
		.video_decoder_0_external_interface_TD_CLK27          (<connected-to-video_decoder_0_external_interface_TD_CLK27>),          //       video_decoder_0_external_interface.TD_CLK27
		.video_decoder_0_external_interface_TD_DATA           (<connected-to-video_decoder_0_external_interface_TD_DATA>),           //                                         .TD_DATA
		.video_decoder_0_external_interface_TD_HS             (<connected-to-video_decoder_0_external_interface_TD_HS>),             //                                         .TD_HS
		.video_decoder_0_external_interface_TD_VS             (<connected-to-video_decoder_0_external_interface_TD_VS>),             //                                         .TD_VS
		.video_decoder_0_external_interface_clk27_reset       (<connected-to-video_decoder_0_external_interface_clk27_reset>),       //                                         .clk27_reset
		.video_decoder_0_external_interface_TD_RESET          (<connected-to-video_decoder_0_external_interface_TD_RESET>),          //                                         .TD_RESET
		.video_decoder_0_external_interface_overflow_flag     (<connected-to-video_decoder_0_external_interface_overflow_flag>),     //                                         .overflow_flag
		.video_stream_export                                  (<connected-to-video_stream_export>),                                  //                             video_stream.export
		.video_dma_controller_0_avalon_dma_master_address     (<connected-to-video_dma_controller_0_avalon_dma_master_address>),     // video_dma_controller_0_avalon_dma_master.address
		.video_dma_controller_0_avalon_dma_master_waitrequest (<connected-to-video_dma_controller_0_avalon_dma_master_waitrequest>), //                                         .waitrequest
		.video_dma_controller_0_avalon_dma_master_write       (<connected-to-video_dma_controller_0_avalon_dma_master_write>),       //                                         .write
		.video_dma_controller_0_avalon_dma_master_writedata   (<connected-to-video_dma_controller_0_avalon_dma_master_writedata>)    //                                         .writedata
	);

