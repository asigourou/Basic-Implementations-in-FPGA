module SeqDetector (BT0,BT0_r,clk,in_seq,out_seq);

input clk;
input BT0;
input in_seq;

output out_seq;
output [3:0] BT0_r;
reg [3:0] BT0_r; 




always@(posedge clk) begin
//BT0_r <= BT0;
	if(BT0 == 1'b0) begin
		//BT0 <= BT0;
		BT0_r <= in_seq;
		
	end


end

assign out_seq = BT0;

endmodule  // End of Moore state machine

