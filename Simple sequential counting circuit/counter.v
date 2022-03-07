module counter (clk,S1,S2,M1,M2,H1,H2,setBT,inc,decr,min1_sw,sec1_sw,hour1_sw,min2_sw,sec2_sw,hour2_sw);

input clk;

input setBT;
reg BT0; 
reg setBT_r;

input inc;
reg BT1; 
reg inc_r;

input decr;
reg BT2; 
reg decr_r;

input min1_sw, min2_sw;
input sec1_sw, sec2_sw;
input hour1_sw, hour2_sw;

output reg[6:0] S1,S2,M1,M2,H1,H2;
reg [31:0] refresh_counter; 

reg [3:0] sec_c1; //counts MS secs
reg [3:0] sec_c2; //counts LS secs
reg [3:0] min_c1; //counts MS mins
reg [3:0] min_c2; //counts LS mins
reg [2:0] hour_c1; //counts MS hours
reg [3:0] hour_c2; //counts LS hours


initial begin
refresh_counter <= 32'b0;
	//Starting hour
	sec_c1 <= 4'b0000;//3sec
	sec_c2 <= 4'b0011; 
	min_c1 <= 4'b0100; //41 min
	min_c2 <= 4'b0001;
	hour_c1 <= 4'b0001; //15 hour
   hour_c2 <= 4'b0101;
	
	S1 <= 7'b0000001; 
	S2 <= 7'b0000110;
	M1 <= 7'b1001100;
	M2 <= 7'b1001111;
	H1 <= 7'b0100100;
	H2 <= 7'b0000100;
end

always @(posedge clk )
begin 
refresh_counter <= refresh_counter + clk;
	if (refresh_counter  > 50000000)
	refresh_counter  <= 32'b0;
end 


always@(posedge clk) begin
   BT0 <= setBT;
   setBT_r <= BT0;
end

always@(posedge clk) begin
   BT1 <= inc;
   inc_r <= BT1;
end

always@(posedge clk) begin
   BT2 <= decr;
   decr_r <= BT2;
end

always @(posedge clk )
begin
	if(refresh_counter == 50000000 & BT0 == 1'b1 & setBT_r == 1'b1) begin 
      sec_c2 <= sec_c2 + 1; //increment sec
				
            if(sec_c2 == 9) begin //check for max value of sec
                sec_c2 <= 0;  //reset seconds
					 sec_c1 <= sec_c1 + 1;
               
					if(sec_c1 == 5) begin
						sec_c1 <=0;
						min_c2 <= min_c2 + 1;
						
						if(min_c2 == 9) begin
							min_c2 <=0;
							min_c1 <= min_c1 + 1;
							
							if(min_c1 == 5) begin
								min_c1 <=0;
								hour_c2 <= hour_c2 + 1;
								
								if(hour_c2 == 9 && hour_c1 < 2) begin
									hour_c2 <=0;
									hour_c1 <= hour_c1 + 1;
								end
								else if (hour_c2 == 4 && hour_c1 == 2)	begin
									hour_c2 <=0;
									hour_c1 <= 0;
								end
						   end
						end
					end
				end
	end 
//refresh_counter == 50000000 & BT0 == 1'b0 & setBT_r == 1'b0 
	else if (sec1_sw==1) begin
	
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			sec_c1 <= sec_c1 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			sec_c1 <= sec_c1 - 1;
	end
	else if (sec2_sw==1) begin
		
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			sec_c2 <= sec_c2 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			sec_c2 <= sec_c2 - 1;
	end
	
	else if (min1_sw==1) begin
	
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			min_c1 <= min_c1 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			min_c1 <= min_c1 - 1;
	end
	else if (min2_sw==1) begin
		
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			min_c2 <= min_c2 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			min_c2 <= min_c2 - 1;
	end
	else if (hour1_sw==1) begin
	
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			hour_c1 <= hour_c1 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			hour_c1 <= hour_c1 - 1;
	end
	else if (hour2_sw==1) begin
		
		if (BT1 == 1'b1 & inc_r == 1'b0  )
			hour_c2 <= min_c2 +1; 
		else if (BT2 == 1'b1 & decr_r == 1'b0)
			hour_c2 <= min_c2 - 1;
	end
end	
		
always @(posedge clk)
begin
	case(sec_c1)
			0: S1 <= 7'b0000001; // "0"  
			1: S1 <= 7'b1001111; // "1" 
			2: S1 <= 7'b0010010; // "2" 
			3: S1 <= 7'b0000110; // "3" 
			4: S1 <= 7'b1001100; // "4" 
			5: S1 <= 7'b0100100; // "5" 
			default: S1 <= 7'b0000001; // "0"
		endcase
			 
		case(sec_c2)
			0: S2 <= 7'b0000001; // "0" 
			1: S2 <= 7'b1001111; // "1" 
			2: S2 <= 7'b0010010; // "2" 
			3: S2 <= 7'b0000110; // "3" 
			4: S2 <= 7'b1001100; // "4" 
			5: S2 <= 7'b0100100; // "5" 
			6: S2 <= 7'b0100000; // "6" 
			7: S2 <= 7'b0001111; // "7" 
			8: S2 <= 7'b0000000; // "8"  
			9: S2 <= 7'b0000100; // "9" 
			default: S2 <= 7'b0000001; // "0"
		endcase



//Minutes LEDs
	
		case(min_c1)
			0: M1 <= 7'b0000001; // "0"  
			1: M1 <= 7'b1001111; // "1" 
			2: M1 <= 7'b0010010; // "2" 
			3: M1 <= 7'b0000110; // "3" 
			4: M1 <= 7'b1001100; // "4" 
			5: M1 <= 7'b0100100; // "5" 
			default: M1 <= 7'b0000001; // "0"
		endcase
									
		case(min_c2)
			0: M2 <= 7'b0000001; // "0" 
			1: M2 <= 7'b1001111; // "1" 
			2: M2 <= 7'b0010010; // "2" 
			3: M2 <= 7'b0000110; // "3" 
			4: M2 <= 7'b1001100; // "4" 
			5: M2 <= 7'b0100100; // "5" 
			6: M2 <= 7'b0100000; // "6" 
			7: M2 <= 7'b0001111; // "7" 
			8: M2 <= 7'b0000000; // "8"  
			9: M2 <= 7'b0000100; // "9" 
			default: M2 <= 7'b0000001; // "0"
		endcase

//Hours LEDs		
	
		case(hour_c1)
			0: H1 <= 7'b0000001; // "0"  
			1: H1 <= 7'b1001111; // "1" 
			2: H1 <= 7'b0010010; // "2" 
			default: H1 <= 7'b0000001; // "0"
		endcase
			
		case(hour_c2)
			0: H2 <= 7'b0000001; // "0" 
			1: H2 <= 7'b1001111; // "1" 
			2: H2 <= 7'b0010010; // "2" 
			3: H2 <= 7'b0000110; // "3" 
			4: H2 <= 7'b1001100; // "4" 
			5: H2 <= 7'b0100100; // "5" 
			6: H2 <= 7'b0100000; // "6" 
			7: H2 <= 7'b0001111; // "7" 
			8: H2 <= 7'b0000000; // "8"  
			9: H2 <= 7'b0000100; // "9" 
			default: H2 <= 7'b0000001; // "0"
		endcase
end

endmodule

