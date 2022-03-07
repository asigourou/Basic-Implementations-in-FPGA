module FSM( clk, LED_out );

input clk;
output [7:0] LED_out;
reg [7:0] LED_out;
reg [1:0] state;
parameter S0=0, S1=1, S2=2, RST=3;


// counting logic that generates a synchronous time_elapsed signal
// it can be used to transition between states after a certain time
reg [31:0] time_elapsed;

initial begin
	time_elapsed <= 32'b0;
	LED_out[7:0] <= 8'b00000000;
	

end

always@ (posedge clk)
begin
	time_elapsed <= time_elapsed + clk;
	

	if (time_elapsed > 50000000)

		begin
			time_elapsed <= 32'b0;
		end

//TODO
end


// state transition logic
always@ (posedge clk) 
begin
	case(state)
		RST : begin
		if (time_elapsed == 50000000) begin
			state <= S0;
			end
		end
		
		S0 : begin
			//TODO
			if (time_elapsed == 50000000) begin
			state <= S1;
			end
		end
		
		S1 : begin
				//TODO
			if (time_elapsed == 50000000) begin
			state <= S2;
			end
		end
		
		S2 : begin
				//TODO
			if (time_elapsed == 50000000) begin		
			//time_elapsed <= 32'b0;
			state <= RST;
			end
		end
		
		default : begin
		state <= RST;
		end
		
	 endcase
end



// combinational output logic
always@(posedge clk ) begin

	case(state)
		RST : begin
			LED_out[7:0] <= 8'b00001111;
		end
		
		S0 : begin 
			LED_out[7:0] <= 8'b00001010;		//TODO
		end
		
		S1 : begin 
			LED_out[7:0] <= 8'b10100000; //TODO
		end
		
		S2 : begin 
			LED_out[7:0] <= 8'b10101010;
		end
		
		default : begin
			LED_out[7:0] <= 8'b00000000; //TODO
		end
	endcase
end

endmodule

