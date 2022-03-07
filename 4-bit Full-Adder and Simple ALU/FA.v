module FA (a,b,out,cs);

input[3:0] a,b;
output[4:0] out;
reg[4:0] out;

input[1:0] cs;


always@(a or b or cs)
begin
	case(cs)
	2'b00 : out <= a + b;
	2'b01 : out <= a | b;
	2'b10 : out <= a & b;
	2'b11 : out <= a ^ b;
	endcase
end
endmodule
