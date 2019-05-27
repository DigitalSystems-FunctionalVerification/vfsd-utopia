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
// Get interface to interact with DUT
//---------------------------------------------------------------------------
function void Driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual Utopia)::get(this, "", $sformatf("vUtopia_Rx_%0d", this.PortID), Rx))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".Rx"});
endfunction: build_phase 

//---------------------------------------------------------------------------
// run(): Run the driver. 
// Get transaction from sequencer and send it to DUT
//---------------------------------------------------------------------------
task Driver::run_phase(uvm_phase phase);

   // Initialize ports
   Rx.cbr.data  <= 0;
   Rx.cbr.soc   <= 0;
   Rx.cbr.clav  <= 0;

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

   ATMCellType Pkt;
   req.pack(Pkt);

   @(Rx.cbr);
   Rx.cbr.clav <= 1;
   for (int i=0; i<=52; i++) begin
      // If not enabled, loop
      while (Rx.cbr.en === 1'b1) @(Rx.cbr);

      // Assert Start Of Cell indicater, assert enable, send byte 0 (i==0)
      Rx.cbr.soc  <= (i == 0);
      Rx.cbr.data <= Pkt.Mem[i];
      @(Rx.cbr);
    end

   Rx.cbr.soc <= 'z;
   Rx.cbr.data <= 8'bx;
   Rx.cbr.clav <= 0;

endtask

`endif // DRIVER__SV
