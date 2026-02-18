module NEW_SLAVE(
        input MOSI, SCLK, CS, load,
        input [7:0]data_in,
        output reg MISO,
	output done,
        output reg[7:0]rx

        );

        parameter mode = 2'd3; //[CPOL, CPHA]

        reg [7:0]tx;
	reg [4:0]count;

	assign done= (count==5'd16);



always@(posedge SCLK or posedge load)begin

	if(load && ^mode)begin
		if(!mode[0])begin
		    MISO<= data_in[7];
		    tx<= {data_in[6:0], 1'b0};
		    count<= 5'b0;
		end
		else begin
		    tx <= data_in;
		    MISO<= 1'b0;
		    count<= 5'b0;
		end
	end 
	else if(load && !(^mode))
		rx<= 8'b0;	

	else if(!(^mode)&& CS==1'b0)begin

		rx <= {rx[6:0], MOSI};
		count= count+1;
	end

	else if(^mode && CS==1'b0)begin

		MISO<= tx[7];
        	tx<= {tx[6:0], 1'b0};
		count= count+1;
	end

end

always@(negedge SCLK or posedge load)begin

	if(load && !(^mode))begin
		if(!mode[0])begin
		    MISO<= data_in[7];
		    tx<= {data_in[6:0], 1'b0};
		    count<= 5'b0;
		end
		else begin
		    tx <= data_in;
		    MISO<= 1'b0;
		    count= 5'b0;
		end
	end
	else if(load && ^mode)
		rx<= 8'b0;	
	else if(^mode && CS==1'b0)begin
		rx <= {rx[6:0], MOSI};
		count= count+1;
	end
	else if(!(^mode) && CS==1'b0)begin
		MISO<= tx[7];
                tx<= {tx[6:0], 1'b0};
		count= count+1;
	end

end

endmodule
  
