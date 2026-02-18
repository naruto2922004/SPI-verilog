module MASTER_test;
reg transmit, MISO, CLK, reset, d_valid;
reg [7:0] data_in;
wire MOSI, SCLK, CS, done;
wire [7:0] rx;
MASTER ins(transmit, MISO, CLK, reset, d_valid, data_in, MOSI, SCLK, CS, done, rx);

always #5 CLK = ~CLK;

initial begin
CLK= 0;
reset= 1;
transmit= 0;
MISO= 0;
d_valid= 0;
data_in= 8'b0;

#20 reset= 0; //S0
#10 transmit= 1; //S0
#10 data_in= 8'b10110011; //S1
    d_valid= 1;
#10; //S2`
#10 MISO= 1; //S3
#10; //S4

#10 MISO= 1; //S5
#10; //S6

#10 MISO= 0; //S7
#10; //S8

#10 MISO= 0; //S9
#10; //S10

#10 MISO= 1; //S11
#10; //S12

#10 MISO= 0; //S13
#10; //S14

#10 MISO= 1; //S15
#10; //S16

#10 MISO= 0; //S17
#10; //S18

#10 transmit= 0; //S19
#10;
end
endmodule




