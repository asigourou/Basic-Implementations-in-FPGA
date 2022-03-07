module ram1port(clk,addr,data,wren,rden,LED_out,q) ;

input clk;
input [4:0] addr;
input [4:0] data;
input wren;
input rden;

output reg [4:0] LED_out;
output [4:0] q;


ram ram1port(
.address (addr),
.clock (clk),
.data (data),
.wren (wren),
.rden (rden),
.q (q)
);



reg [4:0] mem [31:0]; // a 4 bit wide 32 word RAM block.

initial begin
        $display("Loading ram.");
        $readmemh("seq.hex", mem);
    end

always @(posedge clk) 
begin
   if (wren)
      mem[addr] <= data;
	else if (rden)	
		LED_out <= mem[addr];

	  
end
	
endmodule

