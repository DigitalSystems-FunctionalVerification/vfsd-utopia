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

`ifndef GENERATOR__SV
 `define GENERATOR__SV

`include "uvm_atm_cell.sv"
`include "uvm_atm_sequence.sv"

/////////////////////////////////////////////////////////////////////////////
class UNI_sequencer extends uvm_sequencer#(UNI_cell);
   `uvm_sequencer_utils(UNI_sequencer)
      
  //--------------------------------------- 
  // Constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : UNI_sequencer


/////////////////////////////////////////////////////////////////////////////
class NNI_sequencer extends uvm_sequencer#(NNI_cell);
   `uvm_sequencer_utils(NNI_sequencer)

   //--------------------------------------- 
   // Constructor
   //---------------------------------------
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : NNI_sequencer

`endif // GENERATOR__SV
