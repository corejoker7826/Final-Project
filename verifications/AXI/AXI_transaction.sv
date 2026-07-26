class AXI_transaction;


rand	 bit [31:0] addr;

rand     bit 	    write;
rand	 bit [31:0] wdata;
	 	
	 	 bit [1:0]  resp;
	 	 bit [31:0] rdata;
	  	

function void display(string name="");
	
	$display("\n--------------------------------");
	$display(" The Name   =%s",name);
	$display(" WRITE      =%d",write);
	$display(" ADDRESS    =%h",addr);
	$display(" WRITE DATA =%h",wdata);
    $display(" RESPONSE   =%d",resp);
    $display(" READ DATA  =%d",rdata);
    $display("\n--------------------------------");   
endfunction : display

endclass : AXI_transaction