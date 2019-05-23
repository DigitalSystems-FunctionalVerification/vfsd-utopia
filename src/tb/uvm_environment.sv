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
  Agent agents[NumRx];

  //---------------------------------------
  // Scoreboard
  //---------------------------------------   
  Scoreboard scoreboard;
     
  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  // build_phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      scoreboard = Scoreboard::type_id::create("Scoreboard", this);
      
      for (int i = 0; i < NumRx; i++) begin
         agents[i]     = Agent::type_id::create($sformatf("Agent_%0d", i), this);  
         agents[i].ID  = i;  
      end
      
   endfunction : build_phase

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      for (int i = 0; i < NumRx; i++) begin
         agents[i].agent_to_scb_analysis_port.connect(scoreboard.agent_to_scb_analysis_export);
      end
    
  endfunction
 
endclass : Environment

`endif // ENVIRONMENT__SV
