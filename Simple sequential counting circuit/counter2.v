

module counter (clk,S1,S2,M1,M2,H1,H2);

input clk;


output reg[6:0] S1,S2,M1,M2,H1,H2;
reg [31:0] refresh_counter; 

reg [5:0] sec_counter;
reg [5:0] min_counter;
reg [4:0] hour_counter;

reg [2:0] LED_H1 ;
reg [3:0] LED_H2 ;
reg [3:0] LED_M1 ;
reg [3:0] LED_M2 ;
reg [3:0] LED_S1 ;
reg [3:0] LED_S2 ;

initial begin
	refresh_counter <= 32'b0;
	//Starting hour
	sec_counter <= 6'b000011; //3sec
	min_counter <= 6'b011001; //41 min
	hour_counter <= 5'b01001; //9 hour

	S1 <= 7'b0000001; 
	S2 <= 7'b0000110;
	M1 <= 7'b1001100;
	M2 <= 7'b1001111;
	H1 <= 7'b0000001;
	H2 <= 7'b0000100;
end

always @(posedge clk )
begin 
refresh_counter <= refresh_counter + clk;
	if (refresh_counter  > 50000000)
	refresh_counter  <= 32'b0;
	
 
end 

always @(posedge clk )
    begin
       if(refresh_counter == 50000000) begin  //at the beginning of each second
            sec_counter = sec_counter + 1; //increment sec
				
            if(sec_counter == 60) begin //check for max value of sec
                sec_counter = 0;  //reset seconds
					 LED_S1 <= 4'b0000;
					 LED_S2 <= 4'b0000;
					 
                min_counter = min_counter + 1; //increment minutes
					
					if (min_counter == 60) begin //check for max value of min
						min_counter = 0;  //reset minutes
						LED_M1 <= 4'b0000;
						LED_M2 <= 4'b0000;
								
						hour_counter = hour_counter + 1;  //increment hours
									
						if (hour_counter ==  24) begin  //check for max value of hours
							hour_counter = 0; //reset hours
							LED_H1 <= 4'b0000;
							LED_H2 <= 4'b0000;
						end		
					end			
				end
			end	
		end 		

// Seconds LEDs
always @(posedge clk)
begin
 	LED_S1 <= 4'b0000; 
		case(LED_S1 )
			4'b0000: if (sec_counter >= 0  && sec_counter < 10 ) LED_S1 <=4'b0001; // "0"  
			4'b0001: if (sec_counter >= 10 && sec_counter < 20 ) LED_S1 <=4'b0010;  // "1" 
			4'b0010: if (sec_counter >= 20 && sec_counter < 30 ) LED_S1 <=4'b0011;  // "2" 
			4'b0011: if (sec_counter >= 30 && sec_counter < 40)  LED_S1 <=4'b0100;  // "3" 
			4'b0100: if (sec_counter >= 40 && sec_counter < 50 )  end // "4" 
			4'b0101: if (sec_counter >= 50  ) begin S1 = 7'b0100100; LED_S1 <=4'b0000; // "5" 
			default: S1 = 7'b0000001; // "0"
		endcase
	LED_S2 <= 4'b0011;		 
		case(LED_S2)
			4'b0000: if (refresh_counter == 50000000 ) begin S2 = 7'b0000001; LED_S2 <=4'b0001; end // "0"  
			4'b0001: if (refresh_counter == 50000000 ) begin S2 = 7'b1001111; LED_S2 <=4'b0010; end // "1" 
			4'b0010: if (refresh_counter == 50000000 ) begin S2 = 7'b0010010; LED_S2 <=4'b0011; end // "2" 
			4'b0011: if (refresh_counter == 50000000 ) begin S2 = 7'b0000110; LED_S2 <=4'b0100; end // "3" 
			4'b0100: if (refresh_counter == 50000000 ) begin S2 = 7'b1001100; LED_S2 <=4'b0101; end // "4" 
			4'b0101: if (refresh_counter == 50000000 ) begin S2 = 7'b0100100; LED_S2 <=4'b0110; end // "5" 
			4'b0110: if (refresh_counter == 50000000 ) begin S2 = 7'b0100000; LED_S2 <=4'b0111; end // "6" 
			4'b0111: if (refresh_counter == 50000000 ) begin S2 = 7'b0001111; LED_S2 <=4'b1000; end // "7" 
			4'b1000: if (refresh_counter == 50000000 ) begin S2 = 7'b0000000; LED_S2 <=4'b1001; end // "8"  
			4'b1001: if (refresh_counter == 50000000 ) begin S2 = 7'b0000100;  end // "9" 
			default: S2 = 7'b0000001; // "0"
		endcase



//Minutes LEDs
	LED_M1 <= 4'b0100;
		case(LED_M1)
			4'b0000: if (min_counter >= 0 ) begin M1 = 7'b0000001; LED_M1 <=4'b0001; end // "0"  
			4'b0001: if (min_counter >= 10 ) begin M1 = 7'b1001111; LED_M1 <=4'b0010; end // "1" 
			4'b0010: if (min_counter >= 20 ) begin M1 = 7'b0010010; LED_M1 <=4'b0011; end // "2" 
			4'b0011: if (min_counter >= 30 ) begin M1 = 7'b0000110; LED_M1 <=4'b0100; end // "3" 
			4'b0100: if (min_counter >= 40 ) begin M1 = 7'b1001100; LED_M1 <=4'b0101; end // "4" 
			4'b0101: if (min_counter >= 50 ) begin M1 = 7'b0100100;  end // "5" 
			default: M1 = 7'b0000001; // "0"
		endcase
	LED_M2 <= 4'b0001;								
		case(LED_M2)
			4'b0000: if (sec_counter == 60 ) LED_M2 <=4'b0001;  // "0"  
			4'b0001: if (sec_counter == 60 ) LED_M2 <=4'b0010;  // "1" 
			4'b0010: if (sec_counter == 60 ) LED_M2 <=4'b0011; // "2" 
			4'b0011: if (sec_counter == 60 ) LED_M2 <=4'b0100;  // "3" 
			4'b0100: if (sec_counter == 60 ) LED_M2 <=4'b0101;  // "4" 
			4'b0101: if (sec_counter == 60 ) LED_M2 <=4'b0110;  // "5" 
			4'b0110: if (sec_counter == 60 ) LED_M2 <=4'b0111;  // "6" 
			4'b0111: if (sec_counter == 60 ) LED_M2 <=4'b1000;  // "7" 
			4'b1000: if (sec_counter == 60 ) LED_M2 <=4'b1001; // "8"  
			4'b1001: if (sec_counter == 60 )  // "9" 
			default: M2 = 7'b0000001; // "0"
		endcase

//Hours LEDs		
	LED_H1 <= 3'b000;
		case(LED_H1)
			3'b000: if (hour_counter >= 0 ) LED_H1 <=3'b001; end // "0"  
			3'b001: if (hour_counter >= 10 ) LED_H1 <=3'b010; end // "1" 
			3'b010: if (hour_counter >= 20 ) LED_H1 <=3'b000; end // "2" 
			default: H1 = 7'b0000001; // "0"
		endcase
	LED_H2 <= 4'b1001;		
		case(LED_H2)
			4'b0000: if (min_counter == 60 ) LED_H2 <=4'b0001; end // "0"  
			4'b0001: if (min_counter == 60 ) LED_H2 <=4'b0010; end // "1" 
			4'b0010: if (min_counter == 60 ) LED_H2 <=4'b0011; end // "2" 
			4'b0011: if (min_counter == 60 ) LED_H2 <=4'b0100; end // "3" 
			4'b0100: if (min_counter == 60 ) LED_H2 <=4'b0101; end // "4" 
			4'b0101: if (min_counter == 60 ) LED_H2 <=4'b0110; end // "5" 
			4'b0110: if (min_counter == 60 ) LED_H2 <=4'b0111; end // "6" 
			4'b0111: if (min_counter == 60 ) LED_H2 <=4'b1000; end // "7" 
			4'b1000: if (min_counter == 60 ) LED_H2 <=4'b1001; end // "8"  
			4'b1001: if (min_counter == 60 ) LED_H2 <=4'b0000; end // "9" 
			default: H2 = 7'b0000001; // "0"
		endcase
end

always @(posedge clk)
begin
 	LED_S1 <= 4'b0000; 
		case(LED_S1 )
			4'b0000: S1 = 7'b0000001; // "0"  
			4'b0001: S1 = 7'b1001111; // "1" 
			4'b0010: S1 = 7'b0010010; // "2" 
			4'b0011: S1 = 7'b0000110; // "3" 
			4'b0100: S1 = 7'b1001100; // "4" 
			4'b0101: S1 = 7'b0100100; // "5" 
			default: S1 = 7'b0000001; // "0"
		endcase
	LED_S2 <= 4'b0011;		 
		case(LED_S2)
			4'b0000: S2 = 7'b0000001; // "0" 
			4'b0001: S2 = 7'b1001111; // "1" 
			4'b0010: S2 = 7'b0010010; // "2" 
			4'b0011: S2 = 7'b0000110; // "3" 
			4'b0100: S2 = 7'b1001100; // "4" 
			4'b0101: S2 = 7'b0100100; // "5" 
			4'b0110: S2 = 7'b0100000; // "6" 
			4'b0111: S2 = 7'b0001111; // "7" 
			4'b1000: S2 = 7'b0000000; // "8"  
			4'b1001: S2 = 7'b0000100; // "9" 
			default: S2 = 7'b0000001; // "0"
		endcase



//Minutes LEDs
	LED_M1 <= 4'b0100;
		case(LED_M1)
			4'b0000: M1 = 7'b0000001; // "0"  
			4'b0001: M1 = 7'b1001111; // "1" 
			4'b0010: M1 = 7'b0010010; // "2" 
			4'b0011: M1 = 7'b0000110; // "3" 
			4'b0100: M1 = 7'b1001100; // "4" 
			4'b0101: M1 = 7'b0100100; // "5" 
			default: M1 = 7'b0000001; // "0"
		endcase
	LED_M2 <= 4'b0001;								
		case(LED_M2)
			4'b0000: M2 = 7'b0000001; // "0" 
			4'b0001: M2 = 7'b1001111; // "1" 
			4'b0010: M2 = 7'b0010010; // "2" 
			4'b0011: M2 = 7'b0000110; // "3" 
			4'b0100: M2 = 7'b1001100; // "4" 
			4'b0101: M2 = 7'b0100100; // "5" 
			4'b0110: M2 = 7'b0100000; // "6" 
			4'b0111: M2 = 7'b0001111; // "7" 
			4'b1000: M2 = 7'b0000000; // "8"  
			4'b1001: M2 = 7'b0000100; // "9" 
			default: M2 = 7'b0000001; // "0"
		endcase

//Hours LEDs		
	LED_H1 <= 3'b000;
		case(LED_H1)
			3'b000: H1 = 7'b0000001; // "0"  
			3'b001: H1 = 7'b1001111; // "1" 
			3'b010: H1 = 7'b0010010; // "2" 
			default: H1 = 7'b0000001; // "0"
		endcase
	LED_H2 <= 4'b1001;		
		case(LED_H2)
			4'b0000: H2 = 7'b0000001; // "0" 
			4'b0001: H2 = 7'b1001111; // "1" 
			4'b0010: H2 = 7'b0010010; // "2" 
			4'b0011: H2 = 7'b0000110; // "3" 
			4'b0100: H2 = 7'b1001100; // "4" 
			4'b0101: H2 = 7'b0100100; // "5" 
			4'b0110: H2 = 7'b0100000; // "6" 
			4'b0111: H2 = 7'b0001111; // "7" 
			4'b1000: H2 = 7'b0000000; // "8"  
			4'b1001: H2 = 7'b0000100; // "9" 
			default: H2 = 7'b0000001; // "0"
		endcase
end


endmodule
