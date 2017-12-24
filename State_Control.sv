module State_Control(
input                clk,
input                reset_n,    // Active-low reset
input						get_color,
output					run
);

enum logic [3:0] {INITIALIZE, RUN} state, next_state;

always_ff @(posedge clk)
begin
	if(reset_n == 1'b0) 
	begin
		state <= INITIALIZE;
   end
   else 
	begin
		state <= next_state;
	end
end
	
always_comb begin
        // Next state logic
        next_state = state;
        unique case (state)
            INITIALIZE: begin
                if(get_color)
					 next_state = RUN;
            end
				
				RUN: begin
				
				end
			endcase
end

always_comb begin
		  run = 1'b0;
        unique case (state)
            INITIALIZE: begin
                run = 1'b0;
            end
				
				RUN: begin
					run = 1'b1;
				end
			endcase
end

				
endmodule

