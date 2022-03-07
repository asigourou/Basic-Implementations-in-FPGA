module ledfade(clk, LED);

input clk;
output reg LED;

reg [2:0] intensity;
reg [3:0] inc_dec_counter;

reg [2:0] PWM; // internal accumulator

reg [31:0] refresh_counter; 

initial begin
LED <= 0;
inc_dec_counter <= 0;
intensity<= 0;
end


always @(posedge clk )
begin 
refresh_counter <= refresh_counter + clk;
	if (refresh_counter  > 50000000)
	refresh_counter  <= 32'b0;
end
always @(posedge clk) 
begin
{LED,PWM} <= PWM + intensity;

	if (refresh_counter == 50000000 & inc_dec_counter < 8   ) begin
		intensity <= intensity+1;
		inc_dec_counter <= inc_dec_counter + 1;
				
	end
	else if (refresh_counter == 50000000 & inc_dec_counter >= 8 & inc_dec_counter < 16  ) begin
		intensity <= intensity-1;
		inc_dec_counter <= inc_dec_counter + 1;
	end 	
	else if (refresh_counter == 50000000 & inc_dec_counter==16)	begin
		intensity <= 0;
		inc_dec_counter<=0;
		
	end

		
end


		
endmodule
