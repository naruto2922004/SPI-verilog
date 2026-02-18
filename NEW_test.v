module NEW_test;
reg transmit, CLK_M, reset, d_valid, load;
wire MISO;
reg [7:0] data_M;
wire MOSI, SCLK, CS, done_M;
wire [7:0] rx_M;
MASTER ins1(transmit, MISO, CLK_M, reset, d_valid, data_M, MOSI, SCLK, CS, done_M, rx_M);

reg [7:0]data_S;
wire done_S;
wire [7:0]rx_S;
NEW_SLAVE ins2(MOSI, SCLK, CS, load, data_S, MISO, done_S, rx_S);

always #5 CLK_M = ~CLK_M;


initial begin
CLK_M = 0;
reset= 1;
transmit= 0;
d_valid= 0;
data_M= 8'b0;
data_S = 8'b0;

#20 reset= 0; //S0
#10 transmit= 1; //S0
#10 data_M= 8'b10110011; //S1
    d_valid= 1;
    data_S= 8'b11001010;
    load= 1;
#10 load= 0;
#170 transmit= 0;
#10;
end
endmodule

