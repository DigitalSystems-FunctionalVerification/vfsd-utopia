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

typedef class Monitor;

/////////////////////////////////////////////////////////////////////////////
class Monitor extends uvm_monitor;

   `uvm_component_utils(Monitor);

   //--------------------------------------- 
   // Interface, port, seq_item, and ID
   //---------------------------------------
   virtual Utopia                utopia_if;

   uvm_analysis_port #(UNI_cell) Rx_analysis_port;          // Monitor to agent
   uvm_analysis_port #(NNI_cell) Tx_analysis_port;          // Monitor to agent

   UNI_cell                      Rx_transaction_collected;  // Collected Rx data from DUT
   NNI_cell                      Tx_transaction_collected;  // Collected Tx data from DUT

   // uvm_analysis_port #(BaseTr) analysis_port;                  // Monitor to agent
   // BaseTr                      transaction_collected;          // Collected data from Utopia
   int PortID;
   uvm_active_passive_enum       is_active;

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task          run_phase(uvm_phase phase);
   extern task          monitoring_active();
   extern task          monitoring_passive();

endclass : Monitor


//---------------------------------------------------------------------------
// new(): construct an object
//---------------------------------------------------------------------------
function Monitor::new(string name, uvm_component parent);
   super.new(name, parent);

   `uvm_info("MONITOR", "started new", UVM_LOW);
   
   parent.print();

   uvm_config_db #(bit)::get (this,"", "is_active", is_active);

   if ( is_active == UVM_ACTIVE ) begin

      Rx_analysis_port           = new("Rx_analysis_port", this);
      Rx_transaction_collected   = new();

      `uvm_info("MONITOR", "Rx_analysis_port builded", UVM_HIGH);
      `uvm_info("MON", $sformatf("Created Rx_analysis_port ## is_active: %0h", is_active), UVM_HIGH);
      
   end else begin

      Tx_analysis_port           = new("Tx_analysis_port", this);
      Tx_transaction_collected   = new();

      `uvm_info("MONITOR", "Tx_analysis_port builded", UVM_HIGH);
      
   end

   `uvm_info("MONITOR", "finished new", UVM_HIGH);

endfunction : new

//--------------------------------------- 
// Build phase
//---------------------------------------
function void Monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);

   if ( is_active == UVM_ACTIVE ) begin

      if(!uvm_config_db#(virtual Utopia)::get(this, "", $sformatf("vUtopia_Rx_%0d", this.PortID), utopia_if))
      `uvm_fatal("NO_VIF", {"Virtual interface must be set for:", get_full_name(),".utopia_if"});
      
   end else begin // passive agent

      if(!uvm_config_db#(virtual Utopia)::get(this, "", $sformatf("vUtopia_Tx_%0d", this.PortID), utopia_if))
      `uvm_fatal("NO_VIF", {"Virtual interface must be set for:", get_full_name(),".utopia_if"});
      
   end   

endfunction : build_phase


//---------------------------------------------------------------------------
// run(): Run the monitor
//---------------------------------------------------------------------------
task Monitor::run_phase(uvm_phase phase);
   super.run_phase(phase);

   if ( is_active == UVM_ACTIVE ) begin   // Active agent
      
      this.monitoring_active();

   end else begin                               // Passive agent

      this.monitoring_passive();
      
   end

endtask : run_phase

//---------------------------------------------------------------------------
// monitoring passive
//---------------------------------------------------------------------------
task Monitor::monitoring_passive();

   // ATMCellType Pkt;

   // Tx.cbt.clav <= 1;   

   // forever begin

   //    while (Tx.cbt.soc !== 1'b1 && Tx.cbt.en !== 1'b0)
   //    @(Tx.cbt);
   //    for (int i=0; i<=52; i++) begin
   //       // If not enabled, loop
   //       while (Tx.cbt.en !== 1'b0) @(Tx.cbt);
         
   //       Pkt.Mem[i] = Tx.cbt.data;
   //       @(Tx.cbt);
   //    end

   //    Tx.cbt.clav <= 0;
      // transaction_collected.unpack(Pkt);

      // @(posedge Tx.cbt.clk_out);
      //    transaction_collected.VPI       <= Tx.cbt.ATMcell.uni.VPI;
      //    transaction_collected.VCI       <= Tx.cbt.ATMcell.uni.VCI;
      //    transaction_collected.CLP       <= Tx.cbt.ATMcell.uni.CLP;
      //    transaction_collected.PT        <= Tx.cbt.ATMcell.uni.PT;
      //    transaction_collected.HEC       <= Tx.cbt.ATMcell.uni.HEC;
      //    transaction_collected.Payload   <= Tx.cbt.ATMcell.uni.Payload;        

      // analysis_port.write(transaction_collected);
      //DEBUG 
      // transaction_collected.print();

   //  end

endtask

//---------------------------------------------------------------------------
// monitoring active
//---------------------------------------------------------------------------
task Monitor::monitoring_active();

   // ATMCellType Pkt;

   // Tx.cbt.clav <= 1;   

   // forever begin

   //    while (Tx.cbt.soc !== 1'b1 && Tx.cbt.en !== 1'b0)
   //    @(Tx.cbt);
   //    for (int i=0; i<=52; i++) begin
   //       // If not enabled, loop
   //       while (Tx.cbt.en !== 1'b0) @(Tx.cbt);
         
   //       Pkt.Mem[i] = Tx.cbt.data;
   //       @(Tx.cbt);
   //    end

   //    Tx.cbt.clav <= 0;
   //    transaction_collected.unpack(Pkt);

   //    // @(posedge Tx.cbt.clk_out);
   //    //    transaction_collected.VPI       <= Tx.cbt.ATMcell.uni.VPI;
   //    //    transaction_collected.VCI       <= Tx.cbt.ATMcell.uni.VCI;
   //    //    transaction_collected.CLP       <= Tx.cbt.ATMcell.uni.CLP;
   //    //    transaction_collected.PT        <= Tx.cbt.ATMcell.uni.PT;
   //    //    transaction_collected.HEC       <= Tx.cbt.ATMcell.uni.HEC;
   //    //    transaction_collected.Payload   <= Tx.cbt.ATMcell.uni.Payload;        

   //    analysis_port.write(transaction_collected);
   //    //DEBUG 
   //    transaction_collected.print();

   //  end
   
endtask

`endif // MONITOR__SV
