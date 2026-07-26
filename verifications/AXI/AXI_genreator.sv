class AXI_genreator;

	AXI_transaction trans();
	mailbox gen2drv;
    int num_transaction;


 function new(mailbox gen2drv,int num_transaction);
 	this.gen2drv		  = gen2drv;
 	this.num_transaction = num_transaction;
 endfunction 

 task run();
   repeat(num_transaction)
   begin
    	trans=new();

    	assert(trans.randomize());

    	else
    	 $fatal("Randomize Failed");

    	 gen2drv.put(trans);

    	 trans.display("GENERATOR");

    end 
endtask : run

 endclass : AXI_genreator
