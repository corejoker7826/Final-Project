
interface AXI_interface ();
	logic alck;
	logic areset;

// Write Address channels
	logic [31:0] awaddr;
	logic [2:0]  awport;
	logic        awvalid;
	logic		 awready;

// Write Data channels
	logic [31:0] wdata;
	logic 		 wstrb;
	logic        wvalid;
	logic        wready;

// Write Response channels
    logic [1:0]  bresp;
    logic  		 bvalid;
    logic 	     bready;

// Read Address channels
 	logic [31:0] araddr;
 	logic [2:0]	 aport;
 	logic 		 arvalid;
 	logic 		 arready;

// Read Data channels
 	logic [31:0] rdata;
 	logic 		 rresp;
 	logic        rvalid;
 	logic 		 rready;



endinterface : AXI_interface
