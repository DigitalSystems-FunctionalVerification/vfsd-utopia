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

`ifndef SEQUENCE__SV
 `define SEQUENCE__SV

`include "uvm_atm_cell.sv"


/////////////////////////////////////////////////////////////////////////////
class UNI_sequence extends uvm_sequence#(UNI_cell);

   `uvm_object_utils(UNI_sequence)
  
  //--------------------------------------- 
  // Constructor
  //---------------------------------------
  function new(string name = "UNI_sequence");
    super.new(name);
  endfunction //new()
  
  //---------------------------------------
  // create, randomize and send the item to driver
  // from: https://www.verificationguide.com/p/uvm-sequence.html
  //---------------------------------------
   virtual task body();
      `uvm_create(req)
      `uvm_rand_send(req)
   endtask

endclass : UNI_sequence



/////////////////////////////////////////////////////////////////////////////
class NNI_sequence extends uvm_sequence#(NNI_cell);

   `uvm_object_utils(NNI_sequence)
  
  //--------------------------------------- 
  // Constructor
  //---------------------------------------
  function new(string name = "NNI_sequence");
    super.new(name);
  endfunction //new()
  
  //---------------------------------------
  // create, randomize and send the item to driver
  //---------------------------------------
   virtual task body();
      `uvm_create(req)
      `uvm_rand_send(req)
   endtask

endclass : NNI_sequence

`endif // SEQUENCE__SV
