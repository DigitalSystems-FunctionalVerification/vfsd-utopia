/**********************************************************************
 * Definition of the generator class for the ATM testbench
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

`ifndef AGENT__SV
 `define AGENT__SV

// `include "uvm_atm_cell.sv"
`include "uvm_driver.sv"
`include "uvm_monitor.sv"
`include "uvm_atm_sequencer.sv"

/////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------
//						Agent
//-------------------------------------------------------------------------
class Agent extends uvm_agent;

  `uvm_component_utils(Agent)
  
   int ID;

   //--------------------------------------- 
   // Active agent's components
   //---------------------------------------
   Driver         driver_Rx; 
   UNI_sequencer  uni_sequencer_Rx;
   // NNI_sequencer  nni_sequencer_Tx;

   //--------------------------------------- 
   // Passive agent's components
   //---------------------------------------
   Monitor        monitor_Tx; 
  
   extern   function void  build_phase(uvm_phase phase);
   extern   function void  connect_phase(uvm_phase phase);
   extern   function void  end_of_elaboration();
   extern   function       new(string name, uvm_component parent);

endclass //Agent extends uvm_agent

//---------------------------------------  
// Constructor
//---------------------------------------  
function Agent::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction //new()

//--------------------------------------- 
// Build phase
//---------------------------------------
function void Agent::build_phase(uvm_phase phase);
   super.build_phase(phase);

   // passive agents have monitor only
   monitor_Tx = Monitor::type_id::create("Monitor_Tx", this);
   monitor_Tx.PortID = this.ID;
   
   //creating driver and sequencer only for ACTIVE agent
   if(get_is_active() == UVM_ACTIVE)begin  // monitor active

      driver_Rx         = Driver::type_id::create("Driver_Rx", this);
      driver_Rx.PortID  = this.ID;
      uni_sequencer_Rx  = UNI_sequencer::type_id::create("UNI_Sequencer_Rx", this);
      
   end
endfunction

//---------------------------------------  
// Connect phase - connecting the driver and sequencer port
//---------------------------------------
function void Agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

   // connect driver monitor to sequencer port
   if(get_is_active() == UVM_ACTIVE) begin
      driver_Rx.seq_item_port.connect(uni_sequencer_Rx.seq_item_export);      
   end

endfunction

//---------------------------------------  
// End of elaboration phase - debbuging connection
//---------------------------------------
function void Agent::end_of_elaboration();

   driver_Rx.seq_item_port.debug_connected_to();

endfunction

`endif // Agent__SV
