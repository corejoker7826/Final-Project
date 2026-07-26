class AXI_Driver;

	mailbox gen2drv;
	mailbox drv2mon;

	virtual AXI_interface vif;

function new (virtual AXI_interface vif,mailbox gen2drv,mailbox drv2mon);
	this.vif     = vif;
	this.gen2drv = gen2drv;
	this.drv2mon = drv2mon	
endfunction 

task run();
begin
	
end
endtask : run
endclass : AXI_Driver