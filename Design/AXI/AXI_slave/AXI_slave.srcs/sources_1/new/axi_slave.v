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
module axi_slave #(parameter AXI_ADDR_WIDTH=32,
                   parameter DATA_WIDTH=32 )
(
     input wire aclk,
     input wire areset,
 
 // WRITE ADDRESS CHANNEL
 
     input wire [AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
     input wire                      s_axi_awvalid,
    output reg                       s_axi_awready,
 
 //WRITE DATA CHANNEL
 
     input wire [DATA_WIDTH-1:0]     s_axi_wdata,
     input wire [3:0]                s_axi_wstrb,
     input wire                      s_axi_wvalid,
    output reg                       s_axi_wready,
     
 //WRITE RESPONSE CHANNEL
    output reg [1:0]                 s_axi_bresp,
    output reg                       s_axi_bvalid,
     input wire                      s_axi_bready,
 
 //READ ADDRESS CHANNEL
     input wire [AXI_ADDR_WIDTH-1:0] s_axi_araddr,
     input wire                      s_axi_arvalid,
    output reg                       s_axi_arready,
 
 //READ DATA CHANNEL
     output reg [DATA_WIDTH-1:0]     s_axi_rdata,
     output reg    [1:0]             s_axi_rresp,
     output reg                      s_axi_rvalid,
     input  wire                     s_axi_rready, 

// Internal intrface to control fsm
     output reg                      wr_req,
     output reg [AXI_ADDR_WIDTH-1:0] wr_addr,
     output reg [DATA_WIDTH-1:0]     wr_data,
     output reg [3:0]                wr_strb,
     input  wire                     wr_done,
     input  wire [1:0]               wr_resp,
     
     output reg                      rd_req,
     output reg [AXI_ADDR_WIDTH-1:0] rd_addr,
     input wire [DATA_WIDTH-1:0]     rd_data,
     input wire                      rd_valid,
     input wire [1:0]                rd_resp
     
      );



 //FSM STATE FOR WRITE
   localparam WR_IDEL = 2'b00;
   localparam WR_ADDR = 2'b01;
   localparam WR_DATA = 2'b10;
   localparam WR_RESP = 2'b11;

// FSM STATE FOR READ
   localparam RD_IDEL   = 2'b00;
   localparam RD_ACCESS = 2'b01;
   localparam RD_RESP   = 2'b10;

   reg [1:0] wstate,wnext;
   reg [1:0] rstate,rnext;
   reg       write_done_seen;

//=================WRITE OPRATION================//
always@(posedge aclk )
begin
  if(!areset) begin 
     wstate        <= 2'b00;
     s_axi_awready <= 1'b0;
     s_axi_wready  <= 1'b0;
     s_axi_bvalid  <= 1'b0;
     s_axi_bresp   <= 2'b00;
     
     wr_req        <= 1'b0;
     wr_data       <= {DATA_WIDTH{1'b0}};
     wr_addr       <= {AXI_ADDR_WIDTH{1'b0}};
     wr_strb       <= 4'b0000;
  end
   else begin
      wstate <= wnext;
      s_axi_awready  <= 0;
      s_axi_wready   <= 0;
      wr_req         <= 0;
    
    case(wstate)
    
    WR_IDEL : begin
               s_axi_bvalid <= 1'b0;

             end
    WR_ADDR : begin
              s_axi_awready <= 1'b1;
              if(s_axi_awvalid && s_axi_awready)
                wr_addr <= s_axi_awaddr;
             end
    
    WR_DATA : begin
                s_axi_wready <= 1'b1;
               if(s_axi_wvalid && s_axi_wready)
                 begin
                   wr_data <= s_axi_wdata;
                   wr_strb <= s_axi_wstrb;
                   wr_req  <= 1'b1;
                end
               if(wr_done)
                 begin
                  s_axi_bvalid <= 1'b1;
                  s_axi_bresp  <= wr_resp;
                 end
               end
   
   WR_RESP : begin
                if(s_axi_bready)
                s_axi_bvalid <= 1'b0;
             end
    default : begin 
               end
   endcase   
  end                     
end

always@(*)
begin
 case(wstate)
   WR_IDEL : if (s_axi_awvalid)
             wnext = WR_ADDR;
   
   WR_ADDR : if(s_axi_wvalid)
               wnext = WR_DATA;
   
   WR_DATA : if(wr_done)
               wnext = WR_RESP;
   
   WR_RESP : if(s_axi_bready && s_axi_bvalid)
                wnext = WR_IDEL;
   default: begin
                wnext = WR_IDEL;
             end
                
endcase
end

//=================READ OPRATION================//
always@(posedge aclk)
begin
 if(!areset) begin
   s_axi_arready <= 1'b0;
   s_axi_rdata   <= {DATA_WIDTH{1'b0}};
   s_axi_rresp   <= 2'b00;
   s_axi_rvalid  <= 1'b0;
   
   rd_req        <= 1'b0;
   rd_addr       <= {AXI_ADDR_WIDTH{1'b0}};
   rstate        <= 2'b00;
  end
  else begin
  
  case(rstate) 
    RD_IDEL: begin
                s_axi_arready <= 1'b0;
               if (s_axi_arvalid) begin
                        rd_addr       <= s_axi_araddr;
                        s_axi_arready <= 1'b1;
                        rd_req         <= 1'b1;   // issue the read request downstream
                        rstate        <= RD_ACCESS;
               end
              end
   RD_ACCESS : begin
                  if(rd_valid)begin
                  s_axi_rdata  <= rd_data;
                  s_axi_rresp  <= rd_resp;
                  s_axi_rvalid <= 1'b1;
                  rstate       <= RD_RESP;
              end
             end  
   
   RD_RESP: begin
                if(s_axi_rready)
                begin 
                 s_axi_rvalid <= 1'b0;
                 rstate       <= RD_IDEL;
               end
             end
   default: begin
              rstate <= RD_IDEL;
            end
  endcase  
end
end   
endmodule
