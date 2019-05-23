/**********************************************************************
 * Definition of the monitor class for the ATM testbench
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


`ifndef MONITOR__SV
`define MONITOR__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "uvm_atm_cell.sv"

typedef virtual Utopia.TB_Tx vUtopiaTx;

typedef class Monitor;

/////////////////////////////////////////////////////////////////////////////
class Monitor extends uvm_monitor;

   `uvm_component_utils(Monitor);

   //--------------------------------------- 
   // Interface, port, seq_item, and ID
   //---------------------------------------
   vUtopiaTx Tx;		   // Virtual interface with output of DUT
   uvm_analysis_port #(NNI_cell) monitor_to_agent_analysis_port;
   NNI_cell                      trans_collected;
   int PortID;

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task          run_phase(uvm_phase phase);
   extern task          monitor();
endclass : Monitor


//---------------------------------------------------------------------------
// new(): construct an object
//---------------------------------------------------------------------------
function Monitor::new(string name, uvm_component parent);
   super.new(name, parent);

   trans_collected      = new();
   monitor_to_agent_analysis_port  = new("monitor_to_agent_analysis_port", this);

endfunction : new

//--------------------------------------- 
// Build phase
//---------------------------------------
function void Monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);

   if(!uvm_config_db#(virtual Utopia)::get(this, "", $sformatf("vUtopia_Tx_%0d", this.PortID), Tx))
   `uvm_fatal("NO_VIF", {"Virtual interface must be set for:", get_full_name(),".Tx"});

endfunction : build_phase


//---------------------------------------------------------------------------
// run(): Run the monitor
//---------------------------------------------------------------------------
task Monitor::run_phase(uvm_phase phase);
   super.run_phase(phase);

    monitor();

endtask : run_phase

//---------------------------------------------------------------------------
// monitor
//---------------------------------------------------------------------------
task Monitor::monitor();
   forever begin

      @(posedge Tx.cbt.clk_out);
         trans_collected.VPI       <= Tx.cbt.ATMcell.uni.VPI;
         trans_collected.VCI       <= Tx.cbt.ATMcell.uni.VCI;
         trans_collected.CLP       <= Tx.cbt.ATMcell.uni.CLP;
         trans_collected.PT        <= Tx.cbt.ATMcell.uni.PT;
         trans_collected.HEC       <= Tx.cbt.ATMcell.uni.HEC;
         trans_collected.Payload   <= Tx.cbt.ATMcell.uni.Payload;        

      monitor_to_agent_analysis_port.write(trans_collected);
      //DEBUG 
      // trans_collected.print();

    end
endtask

`endif // MONITOR__SV
