`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 17:53:39
// Design Name: 
// Module Name: syn_fifo
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
module syn_fifo#(parameter SIZE=32,
                 parameter DEPTH=16)
 (
        input wire            clk,
        input wire            reset,
        
        input wire            wr_en,
        input wire            rd_en,
        input wire [SIZE-1:0] data_in,
        
       output wire            fifo_empty,
       output wire            fifo_full,
       output reg  [SIZE-1:0] data_out 
       );
    
    reg [SIZE-1:0] mem[0:DEPTH-1];
      
//***** pointer to enter the data into fifo*****
    reg [$clog2(DEPTH)-1:0] rd_ptr;
    reg [$clog2(DEPTH)-1:0] wr_ptr;
    
    
//*****checking the condition for fifo full and empty*****
assign fifo_full  = ((wr_ptr+1'b1) == rd_ptr);
assign fifo_empty = (wr_ptr == rd_ptr);

//*****For Writing data into fifo*****
always@(posedge clk,negedge reset)
begin
   if(!reset)begin
       wr_ptr      <= 4'b0000;
       mem[wr_ptr] <= 32'd0;
    end
   else if (wr_ptr && !fifo_full) // checking fifo is empty or not for writing data
      begin 
       mem[wr_ptr] <= data_in;
       wr_ptr      <= wr_ptr+1;
     end
 end 

 
//*****For Reading data from fifo*****
always@(posedge clk,negedge reset)
begin
   if(!reset) begin
       rd_ptr <= 4'b0000;
       data_out<= 32'd0;
    end
   else if(rd_ptr && !fifo_empty)// checking fifo is full or not for reading data
      begin
        data_out <= mem[rd_ptr];
        rd_ptr   <= rd_ptr+1;
      end
end


endmodule
