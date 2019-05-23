/**********************************************************************
 * Definition of the scoreboard class for the ATM testbench
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

`ifndef SCOREBOARD__SV
 `define SCOREBOARD__SV

`include "config.sv"
`include "uvm_atm_cell.sv"

class Scoreboard extends uvm_scoreboard;
 
  `uvm_component_utils(Scoreboard)
  `uvm_analysis_imp_decl(_name)

  uvm_analysis_export#(NNI_cell)          agent_to_scb_analysis_export;
  uvm_tlm_analysis_fifo#(NNI_cell)        get_data_fifo;
  // uvm_analysis_imp#(NNI_cell, Scoreboard) item_collected_export; // legacy
 
  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // item_collected_export = new("item_collected_export", this);
    agent_to_scb_analysis_export  = new("agent_to_scb_analysis_export", this);
    get_data_fifo                 = new("get_data_fifo", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    agent_to_scb_analysis_export.connect(get_data_fifo.analysis_export);
  endfunction: connect_phase
   
  // write
  virtual function void write(NNI_cell pkt);
    `uvm_info("WRITE ON SCOREBOARD", "SCB:: Pkt recived", UVM_LOW);
    //DEBUG 
    // pkt.print();
  endfunction : write
 
endclass : Scoreboard

`endif // SCOREBOARD__SV
