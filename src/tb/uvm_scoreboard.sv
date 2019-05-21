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

  uvm_analysis_imp#(NNI_cell, Scoreboard) item_collected_export;
 
  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction: build_phase
   
  // write
  virtual function void write(NNI_cell pkt);
    $display("SCB:: Pkt recived");
    pkt.print();
  endfunction : write
 
endclass : Scoreboard

`endif // SCOREBOARD__SV
