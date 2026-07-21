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
    output wire [1:0]           s_axi_bresp,
    output wire                 s_axi_bvalid,
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
endmodule
