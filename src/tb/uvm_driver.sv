/**********************************************************************
 * Definition of an ATM driver
 *
 * Author: Chris Spear
 * Revision: 1.01
 * Last modified: 8/2/2011
 *
 * (c) Copyright 2008-2011, Chris Spear, Greg Tumbush. *** ALL RIGHTS RESERVED ***
 * http://chris.spear.net
 *
 *  This source file may be used and distributed without restriction
 *  provided that this copyright statement is not removed from the file
 *  and that any derivative work contains this copyright notice.
 *
 * Used with permission in the book, "SystemVerilog for Verification"
 * By Chris Spear and Greg Tumbush
 * Book copyright: 2008-2011, Springer LLC, USA, Springer.com
 *********************************************************************/

`ifndef DRIVER__SV
`define DRIVER__SV

`include "uvm_atm_cell.sv"

typedef virtual Utopia.TB_Rx vUtopiaRx;

typedef class Driver;

/////////////////////////////////////////////////////////////////////////////
class Driver extends uvm_driver #(UNI_cell);
   `uvm_component_utils(Driver);

   vUtopiaRx Rx;  // Virtual interface for transmitting cells
   // vUtopiaRx Rx;  // Virtual interface for transmitting cells
   int PortID;
 
   extern         function       new(string name, uvm_component parent);
   extern virtual function void  build_phase(uvm_phase phase);
   extern         task           run_phase(uvm_phase phase);
   extern virtual task           drive();

endclass : Driver


//---------------------------------------------------------------------------
// new(): Construct a driver object
//---------------------------------------------------------------------------
function Driver::new(string name, uvm_component parent);   
   super.new(name, parent);
endfunction : new 

//---------------------------------------------------------------------------
// build(): Create the driver. 
// Get interface for interaction with DUT
//---------------------------------------------------------------------------
function void Driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual Utopia)::get(this, "", $sformatf("vUtopia_Rx_%0d", this.PortID), Rx))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".Rx"});
endfunction: build_phase
 

//---------------------------------------------------------------------------
// run(): Run the driver. 
// Get transaction from sequencer, send into DUT
//---------------------------------------------------------------------------
task Driver::run_phase(uvm_phase phase);

   forever begin
      seq_item_port.get_next_item(req);
      // respond_to_transfer(req);
      drive();
      seq_item_port.item_done();
   end
endtask : run_phase

//---------------------------------------------------------------------------
// drive
//---------------------------------------------------------------------------
task Driver::drive();
   // @(posedge Rx.TopReceive.clk_in);
   // req.print();
endtask

`endif // DRIVER__SV
