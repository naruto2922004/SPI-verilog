
module SLAVE1(
    input  MOSI, SCLK, CS, reset, CLK,
    input [7:0]data_in,
    output reg MISO,
    output done,
    output reg[7:0]rx
    );

    parameter mode = 2'd3; //[CPOL, CPHA]
    reg [4:0]count;
    reg [7:0]tx;
    reg t;

    wire rising,falling;

    assign rising= (SCLK && (!t));

    assign falling= (!SCLK && t);

    

    always@(posedge CLK)begin

        if(reset | CS)begin

            tx   <= 8'd0;

            rx   <= 8'd0;

            count<= 5'd0;

            t<= mode[1];

            MISO <= 1'b0;   

        end

        else begin

            t<=SCLK;

            if(count==5'b0)begin
		if(!mode[0])begin
		    MISO<= data_in[7];
		    tx<= {data_in[6:0], 1'b0};
		end
		else
		    tx <= data_in;
	    end

            if((^mode && falling)|(!(^mode) && rising))begin

                rx <= {rx[6:0], MOSI};

                count<=count+1;

            end

            if((^mode && rising)|(!(^mode) && falling))begin

                MISO<= tx[7];

                tx<= {tx[6:0], 1'b0};

                 count<=count+1;

            end

            if(count==5'd16)

                count<=5'd0;

        end

    end

   

assign done= (count==5'd16);  
endmodule

