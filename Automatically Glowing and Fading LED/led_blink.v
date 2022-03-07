module led_blink(clk,led);

input clk;
output led;

reg [31:0] counter;
reg led_status;

initial begin
	counter <= 32'b0;
	led_status <= 1'b0;
end

always @ (posedge clk) 
begin
	counter <= counter + 1'b1;

	if (counter > 50000000)

		begin
			led_status <= !led_status;
			counter <= 32'b0;
		end


end

assign led=led_status;

endmodule 
