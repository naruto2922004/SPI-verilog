module SLAVE_test;
reg MOSI, SCLK, CS, reset, CLK;
reg [7:0]data_in;	
wire MISO, done;
wire [7:0]rx;

SLAVE ins(MOSI, SCLK, CS, reset, CLK, data_in, MISO, done, rx);
parameter mode= 2'd2;//[CPOL, CPHA]

always #5 CLK = ~CLK;

initial begin
MOSI= 0;
SCLK= mode[1];
CS= 1;
reset= 1;
CLK= 0;
data_in = 8'b0;

#20 reset= 0;
#10 CS= 0;
#10 data_in= 8'b10110011;
MOSI= 1;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 1;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 0;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 0;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 1;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 0;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 1;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
MOSI= 0;
#10 SCLK= ~SCLK;
#10 SCLK= ~SCLK;
#20;
end
endmodule
