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
// `include "uvm_driver.sv"
// `include "uvm_monitor.sv"
// `include "config.sv"
// `include "scoreboard.sv"
// `include "coverage.sv"
// `include "cpu_ifc.sv"
// `include "cpu_driver.sv"

class Environment extends uvm_env;
 
//   Agent agent;
   
  `uvm_component_utils(Environment)
     
  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   //  agent = Agent::type_id::create("mem_agnt", this);
  endfunction : build_phase
 
endclass : Environment

`endif // ENVIRONMENT__SV
