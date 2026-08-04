`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2026 12:47:54
// Design Name: 
// Module Name: tb_axi_slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module tb_axi_slave#(parameter AXI_ADDR_WIDTH=32,
                   parameter DATA_WIDTH=32 );
                   
        reg aclk;
        reg areset;
 
 // WRITE ADDRESS CHANNEL
 
       reg [AXI_ADDR_WIDTH-1:0] s_axi_awaddr;
       reg                      s_axi_awvalid;
       wire                     s_axi_awready;
 
 //WRITE DATA CHANNEL
 
       reg [DATA_WIDTH-1:0]     s_axi_wdata;
       reg [3:0]                s_axi_wstrb;
       reg                      s_axi_wvalid;
       wire                     s_axi_wready;
     
 //WRITE RESPONSE CHANNEL
       wire [1:0]               s_axi_bresp;
       wire                     s_axi_bvalid;
       reg                      s_axi_bready;
 
 //READ ADDRESS CHANNEL
      reg [AXI_ADDR_WIDTH-1:0]  s_axi_araddr;
      reg                       s_axi_arvalid;
      wire                      s_axi_arready;
 
 //READ DATA CHANNEL
      wire [DATA_WIDTH-1:0]     s_axi_rdata;
      wire    [1:0]             s_axi_rresp;
      wire                      s_axi_rvalid;
      reg                       s_axi_rready; 

// Internal intrface to control fsm
      wire                      wr_req;
      wire [AXI_ADDR_WIDTH-1:0] wr_addr;
      wire[DATA_WIDTH-1:0]      wr_data;
      wire [3:0]                wr_strb;
      reg                       wr_done;
      reg  [1:0]                wr_resp;
     
      wire                      rd_req;
      wire [AXI_ADDR_WIDTH-1:0] rd_addr;
      reg [DATA_WIDTH-1:0]      rd_data;
      reg                       rd_valid;
      reg  [1:0]                rd_resp ;    

 
axi_slave DUT (.aclk(aclk),
               .areset(areset),
               .s_axi_awaddr(s_axi_awaddr),
               
               .s_axi_awvalid(s_axi_awvalid),
               .s_axi_awready(s_axi_awready),
               
               .s_axi_wdata (s_axi_wdata),
               .s_axi_wstrb (s_axi_wstrb),
               .s_axi_wvalid(s_axi_wvalid),
               .s_axi_wready(s_axi_wready),
               
               .s_axi_bresp(s_axi_bresp),
               .s_axi_bvalid(s_axi_bvalid),
               .s_axi_bready(s_axi_bready),
               
               .s_axi_araddr(s_axi_araddr),
               .s_axi_arvalid(s_axi_arvalid),
               .s_axi_arready(s_axi_arready),
               
               .s_axi_rdata (s_axi_rdata),
               .s_axi_rresp(s_axi_rresp),
               .s_axi_rvalid(s_axi_rvalid),
               .s_axi_rready(s_axi_rready),
               
               .wr_req(wr_req),
               .wr_addr(wr_addr),
               .wr_data(wr_data),
               .wr_strb(wr_strb),
               .wr_done(wr_done),
               .wr_resp(wr_resp),
               
               .rd_req(rd_req),
               .rd_addr(rd_addr),
               .rd_data(rd_data),
               .rd_valid(rd_valid),
               .rd_resp(rd_resp)
               );
    
    always #5 aclk = ~aclk;
    
    initial begin
      aclk = 0;
     areset=0;
     
     s_axi_awaddr  =0;
     s_axi_awvalid =0;
     
     s_axi_wdata   =0;
     s_axi_wstrb   =0;
     s_axi_wvalid  =0;
     s_axi_bready  =0;
     s_axi_araddr  =0;
     s_axi_arvalid =0;
     s_axi_rready  =0;  
     
     wr_done =0;
     wr_resp =0;
     
     rd_data =0;
     rd_resp  =0;
     rd_valid =0;
  
  #20;
      areset = 1;   
      
    @(posedge aclk);
    s_axi_awaddr  <= 12'h010;
    s_axi_awvalid <= 1;

    @(posedge aclk);
    s_axi_awvalid <= 0;

    @(posedge aclk);
    s_axi_wdata <= 32'h12345678;
    s_axi_wstrb <= 4'hF;
    s_axi_wvalid<= 1;

    @(posedge aclk);
    s_axi_wvalid <= 0;  
    
     #20;
    wr_done = 1;
    wr_resp = 2'b00;

    @(posedge aclk);
    wr_done = 0;

    // Accept write response
    #20;
    s_axi_bready = 1;

    @(posedge aclk);
    s_axi_bready  = 0;

 
  #20;

    @(posedge aclk);
    s_axi_araddr  <= 12'h010;
    s_axi_arvalid <= 1;

    @(posedge aclk);
    s_axi_arvalid <= 0;

 
    #20;
    rd_valid = 1;
    rd_data  = 32'h12345678;
    rd_resp  = 2'b00;

    @(posedge aclk);
    rd_valid = 0;

 
    #20;
   s_axi_rready = 1;

    @(posedge aclk);
    s_axi_rready = 0;

    #50;
    $finish;  
    end      
endmodule
