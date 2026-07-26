`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2026 11:03:44
// Design Name: 
// Module Name: address_decoder
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
module address_decoder#(parameter AXI_ADDR=32,
                        parameter SRAM_ADDR=8
                        )(
         input wire [AXI_ADDR-1:0]  axi_addr,
        output wire [SRAM_ADDR-1:0] sram_addr,
        output wire                 addr_valid
         );
   
   assign sram_addr = axi_addr[9:2];
   
   assign addr_valid = (axi_addr >= 32'h00000000)&&(axi_addr <=32'h000003FC);               
                        
endmodule
