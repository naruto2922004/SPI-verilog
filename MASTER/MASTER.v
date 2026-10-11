
module MASTER(

    input transmit, MISO, CLK, reset, d_valid,

    input [7:0] data_in,

    output reg MOSI, SCLK, 

    output CS, done,

    output reg [7:0] rx

);

    

    parameter mode = 2'd3; //[CPOL, CPHA]

    reg [4:0] ps, ns;

    reg [7:0] tx;



    assign CS = (ps == 5'd0);

    assign done = (ps==5'd19);



    always @(posedge CLK) begin

        if (reset) begin

            ps   <= 5'd0;

            tx   <= 8'd0;

            rx   <= 8'd0;

            MOSI <= 1'b0;

            SCLK <= mode[1];

        end else begin

            ps <= ns;



            if (ps == 5'd2) begin

                if(!mode[0])begin
		    MOSI<= data_in[7];
		    tx<= {data_in[6:0], 1'b0};
		end
		else
		    tx <= data_in;

                SCLK <= mode[1];

            end 

            else if (ps >= 5'd3 && ps <= 5'd18) begin

                SCLK <= !SCLK;

                if (SCLK == ^mode)

                    rx <= {rx[6:0], MISO};

                else begin

                    MOSI <= tx[7];

                    tx   <= {tx[6:0], 1'b0};

                end

            end

        end      

    end 



    always @(*) begin

        

        if(ps==5'd0)

            ns = transmit ? 5'd1 : 5'd0;

        else if(ps==5'd1)

            ns = d_valid? 5'd2:5'd1;

        else if(ps>=5'd2 && ps<=5'd18)

            ns = ps + 1'b1;

        else if(ps==5'd19)

            ns = transmit ? 5'd1 : 5'd0;

        else

            ns = 5'd0;

  

    end

endmodule