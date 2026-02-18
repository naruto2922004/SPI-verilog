module NEW_SLAVE_test;
reg MOSI, SCLK, CS, load;
reg [7:0]data_in;	
wire MISO;
wire done;
wire [7:0]rx;

NEW_SLAVE ins(MOSI, SCLK, CS, load, data_in, MISO, done, rx);
parameter mode = 2'd3; //[CPOL, CPHA]
initial begin
CS=1;
load=0;
SCLK= mode[1];
MOSI= 0;
data_in= 0;

#10 CS= 0;
#10 data_in= 8'b10110011;
#10 load= 1;
#10 load= 0;

if(mode[0])
#10 SCLK= ~SCLK;
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
if(!mode[0])
#10 SCLK= ~SCLK;
#20;
end
endmodule
