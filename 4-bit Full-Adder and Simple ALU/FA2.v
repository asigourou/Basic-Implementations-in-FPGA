module FA2 (cout,sum,a,b,cin);

input[3:0] a,b;
input cin;

output cout;
reg cout;
output[3:0] sum;
reg[3:0] sum;

always@(a or b or cin)

begin
assign sum = a ^ b ^ cin; 
assign cout = (a & b) | (b & cin) | (a & cin);
end

endmodule
