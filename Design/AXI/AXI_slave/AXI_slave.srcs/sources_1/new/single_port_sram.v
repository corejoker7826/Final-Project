`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2026 09:38:14
// Design Name: 
// Module Name: single_port_sram
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
// Memory depth = 256 words
// Total memory = 256 * 32 =8192  bits = 1KB
// Data width   = 32 bit
// Address width = 8 bit  
// addr width = 2log(T/DW)
module single_port_sram #(parameter DATA_WIDTH = 32,
                          parameter SRAM_ADDR_WIDTH = 8)
      (
         input wire                       clk,
         input wire                       sram_cs,         // chip select
         input wire                       sram_wen,        //write enable
         input wire [DATA_WIDTH-1:0]      sram_wdata,      // write data
         input wire [SRAM_ADDR_WIDTH-1:0] sram_addr,       // Address
        output reg  [DATA_WIDTH-1:0]      sram_rdata       // read data               

    );
    
 reg [DATA_WIDTH-1:0] mem [0:(1<<SRAM_ADDR_WIDTH)-1];
 
//WRITE DATA INTO MEMORY   
 always@(posedge clk )
 begin
   if(sram_cs && sram_wen)
    mem[SRAM_ADDR_WIDTH] <= sram_wdata;
  end

// READ DATA FROM MEMORY
always@ (posedge clk)
begin
  if(sram_cs && ! sram_wen)
   sram_rdata <= mem[SRAM_ADDR_WIDTH];
end
endmodule
