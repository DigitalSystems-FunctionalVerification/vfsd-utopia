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

  // uvm_analysis_port#(add_sub_seq_item) agent_mon_port;

   //--------------------------------------- 
   // Active agent's components
   //---------------------------------------
   Driver         driver_Tx;
   Driver         driver_Rx;  
   UNI_sequencer  uni_sequencer_Tx;
   UNI_sequencer  uni_sequencer_Rx;

   //--------------------------------------- 
   // Passive agent's components
   //---------------------------------------
   // add_sub_monitor   monitor;
  
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

   // agent_mon_port = new("agent_mon_port", this);

   // passive agents have monitor only
//  monitor = add_sub_monitor::type_id::create("monitor", this);
   
   //creating driver and sequencer only for ACTIVE agent
   if(get_is_active() == UVM_ACTIVE)begin  // monitor active

      driver_Tx         = Driver::type_id::create("Driver_Tx", this);
      driver_Rx         = Driver::type_id::create("Driver_Rx", this);
      uni_sequencer_Tx  = UNI_sequencer::type_id::create("UNI_Sequencer_Tx", this);
      
   end
endfunction

//---------------------------------------  
// Connect phase - connecting the driver and sequencer port
//---------------------------------------
function void Agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

   // connect driver monitor to sequencer port
   if(get_is_active() == UVM_ACTIVE) begin

      driver_Tx.seq_item_port.connect(uni_sequencer_Tx.seq_item_export);


      // for (int i = 0; i < NumRx; i++) begin
      //    drivers_Rx[i].seq_item_port.connect(uni_sequencers_Rx[i].seq_item_export);
      // end
      
   end
   
   // connect monitor port to agent port
   // monitor.item_collected_port.connect(agent_mon_port);

endfunction

//---------------------------------------  function void Agent::end_of_elaboration(uvm_phase phase);
// End of elaboration phase - debbuging connection
//---------------------------------------
function void Agent::end_of_elaboration();

   // for (int i = 0; i < NumTx; i++) begin
      // drivers_Tx[i].seq_item_port.debug_connected_to();
      // uni_sequencers_Tx[i].seq_item_export.debug_provided_to();
   // end

endfunction

`endif // Agent__SV
