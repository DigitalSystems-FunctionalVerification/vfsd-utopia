/**********************************************************************
 * Definition of the environment class for the ATM testbench
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


`ifndef ENVIRONMENT__SV
`define ENVIRONMENT__SV

`include "uvm_agent.sv"
`include "uvm_scoreboard.sv"

class Environment extends uvm_env;
   `uvm_component_utils(Environment)

  //---------------------------------------
  // Agent
  //---------------------------------------   
  Agent agents_active   [`RxPorts];
  Agent agents_passive  [`TxPorts];  

  //---------------------------------------
  // Scoreboard
  //---------------------------------------   
  Scoreboard scoreboard;
     
  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  // Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Scoreboard creation
      scoreboard = Scoreboard::type_id::create("Scoreboard", this);
      
      // Active Agents creation
      for (int i = 0; i < `RxPorts; i++) begin
         agents_active[i]           = Agent::type_id::create($sformatf("Agent_active_%0d", i), this);  
         agents_active[i].ID        = i;  
         agents_active[i].is_active = UVM_ACTIVE;
         `uvm_info("ENV", $sformatf("Created ACTIVE Agent %0d is_active: %0h", i, agents_active[i].is_active), UVM_HIGH);
      end

      // Passive Agents creation
      for (int i = 0; i < `TxPorts; i++) begin
         agents_passive[i]          = Agent::type_id::create($sformatf("Agent_passive_%0d", i), this);  
         agents_passive[i].ID       = i;  
         agents_passive[i].is_active = UVM_PASSIVE;
         `uvm_info("ENV", $sformatf("Created PASSIVE Agent %0d, is_active: %0h", i, agents_passive[i].is_active), UVM_HIGH);
      end
      
   endfunction : build_phase

   // Connect phase
   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);

      // Connecting passive agents port in scoreboard
      for (int i = 0; i < `RxPorts; i++) begin
         agents_active[i].Rx_analysis_port.connect(scoreboard.dut_input_port);
      end

      for (int i = 0; i < `TxPorts; i++) begin
         agents_passive[i].Tx_analysis_port.connect(scoreboard.dut_output_port);
      end
    
  endfunction
 
endclass : Environment

`endif // ENVIRONMENT__SV
