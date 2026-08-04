`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2026 10:53:04
// Design Name: 
// Module Name: sram_controller
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
module sram_controller#(parameter AXI_ADDR_WIDTH  = 32,
                        parameter SRAM_ADDR_WIDTH = 8,
                        parameter DATA_WIDTH      = 32)
   (
                        
     input wire clk,
     input wire reset,
     
     //FROM AXI SLAVE 
     input wire     wr_req,
     input wire     re_req,
     
     input wire [AXI_ADDR_WIDTH-1:0] wr_addr,
     input wire [DATA_WIDTH-1:0]     wr_data,
     input wire [3:0]                wr_strb,
    output reg                       wr_done,
    output reg  [1:0]                wr_resp,
    
    
     input wire [AXI_ADDR_WIDTH-1:0] rd_addr,
    output reg  [DATA_WIDTH-1:0]     rd_data, 
    output reg                       rd_valid,
    output reg                       rd_resp,                    

   //--------TO SRAM SIGNALS------------//
     output reg [SRAM_ADDR_WIDTH-1:0] sram_addr,
     output reg [DATA_WIDTH-1:0]      sram_wdata,
     output reg                       sram_cs,
     output reg                       sram_wen,
     input  wire[DATA_WIDTH-1:0]      sram_rdata,
     input  wire                      sram_ready
      );
      
      localparam RESP_OKAY   =2'b00;
      localparam RESP_SLVEER =2'b11;
      
endmodule
