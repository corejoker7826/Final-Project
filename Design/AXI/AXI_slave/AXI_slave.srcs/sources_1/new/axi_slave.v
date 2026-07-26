`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 11:12:30
// Design Name: 
// Module Name: axi_slave
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
module axi_slave #(parameter ADDR_WIDTH=32,
                   parameter DATA_WIDTH=32 )
(
     input wire aclk,
     input wire areset,
 
 // WRITE ADDRESS CHANNEL
 
     input wire [ADDR_WIDTH-1:0] s_axi_awaddr,
     input wire  [2:0]           s_axi_awport,
     input wire                  s_axi_awvalid,
    output reg                   s_axi_awready,
 
 //WRITE DATA CHANNEL
 
     input wire [DATA_WIDTH-1:0] s_axi_wdata,
     input wire                  s_axi_wstrb,
     input wire                  s_axi_wvalid,
    output reg                   s_axi_wready,
     
 //WRITE RESPONSE CHANNEL
    output reg [1:0]            s_axi_bresp,
    output reg                  s_axi_bvalid,
     input wire                 s_axi_bready,
 
 //READ ADDRESS CHANNEL
     input wire [ADDR_WIDTH-1:0] s_axi_araddr,
     input wire  [2:0]           s_axi_arport,
     input wire                  s_axi_arvalid,
    output reg                   s_axi_arready,
 
 //READ DATA CHANNEL
     output reg [DATA_WIDTH-1:0] s_axil_rdata,
     output reg    [1:0]         s_axil_rresp,
     output reg                  s_axil_rvalid,
     input  wire                 s_axil_rready 

    );


// ADDRESS REGISTER
   reg [ADDR_WIDTH-1:0] awaddr_reg;
   reg [ADDR_WIDTH-1:0] araddr_reg;
   
// DATA REGISTER
   reg [DATA_WIDTH-1:0] wdata_reg;
   reg [DATA_WIDTH-1:0] rdata_reg;
   
// CONTROL SIGNLAS
   reg                  write_req;
   reg                  read_req;
 
 //FSM STATE FOR WRITE
   localparam W_IDEL = 2'b00;
   localparam W_DATA = 2'b01;
   localparam W_RESP = 2'b10;
   localparam W_DONE = 2'b11;

// FSM STATE FOR READ
   localparam RD_IDEL = 2'b00;
   localparam RD_DATA = 2'b01;
   localparam RD_RESP = 2'b10;

   reg [1:0] w_state;
   reg [1:0] r_state;

always@(posedge aclk or posedge areset)
begin
  if(!areset) begin
     w_state       <= W_IDEL;
     s_axi_awready <= 1'b0;
     s_axi_wready  <= 1'b0;
     s_axi_bresp   <= 2'b00;
     s_axi_bvalid  <= 1'b0;
     
     //INTERNAL REGISTER
     awaddr_reg    <= 32'b0;
     araddr_reg    <= 32'b0;
     wdata_reg     <= 32'b0;
     
   end
     
       
end
endmodule
