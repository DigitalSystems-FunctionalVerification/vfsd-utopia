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
   uvm_analysis_port #(UNI_cell) Rx_analysis_port;
   uvm_analysis_port #(NNI_cell) Tx_analysis_port;
  
   int ID;

   //--------------------------------------- 
   // Active agent's components
   //---------------------------------------
   Driver         driver_Rx; 
   UNI_sequencer  uni_sequencer_Rx;

   //--------------------------------------- 
   // Passive agent's components
   //---------------------------------------
   Monitor  monitor; 

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

   if ( get_is_active() == UVM_ACTIVE ) begin

      uvm_config_db #(uvm_active_passive_enum)::set (this, "monitor_rx", "is_active", UVM_ACTIVE);

      monitor           = Monitor::type_id::create("monitor_rx", this);
      monitor.PortID    = this.ID;
      // monitor.is_active = UVM_ACTIVE;

      driver_Rx         = Driver::type_id::create("Driver_Rx", this);
      driver_Rx.PortID  = this.ID;
      uni_sequencer_Rx  = UNI_sequencer::type_id::create("UNI_Sequencer_Rx", this);

      Rx_analysis_port = new(.name("Rx_analysis_port"), .parent(this));   
      
   end else begin
   
      uvm_config_db #(uvm_active_passive_enum)::set (this, "monitor_tx", "is_active", UVM_PASSIVE);

      monitor           = Monitor::type_id::create("monitor_tx", this);
      monitor.PortID    = this.ID;
      // monitor.is_active = UVM_PASSIVE;

      Tx_analysis_port = new(.name("Tx_analysis_port"), .parent(this));   
      
   end

endfunction

//---------------------------------------  
// Connect phase - connecting the driver and sequencer port
//---------------------------------------
function void Agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

   if ( get_is_active() == UVM_ACTIVE ) begin

      driver_Rx.seq_item_port.connect(uni_sequencer_Rx.seq_item_export);
      monitor.Rx_analysis_port.connect(Rx_analysis_port);
      
   end else begin
      // connect monitor port to agent port
      monitor.Tx_analysis_port.connect(Tx_analysis_port);
      
   end

endfunction


//---------------------------------------  
// End of elaboration phase - debbuging connection
//---------------------------------------
function void Agent::end_of_elaboration();

   //DEBUG 
   if ( get_is_active() ) begin

      driver_Rx.seq_item_port.debug_connected_to();
      monitor.Rx_analysis_port.debug_connected_to();
      
   end else begin
      
      monitor.Tx_analysis_port.debug_connected_to();

   end

endfunction

`endif // Agent__SV
