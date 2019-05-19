/**********************************************************************
 * Utopia ATM testbench
 *
 * To simulate this example with stimulus, invoke simulation on
 * 10.00.00_example_top.sv.  This top-level file includes all of the
 * example files in chapter 10.
 *
 * Author: Lee Moore, Stuart Sutherland
 *
 * (c) Copyright 2003, Sutherland HDL, Inc. *** ALL RIGHTS RESERVED ***
 * www.sutherland-hdl.com
 *
 * This example is based on an example from Janick Bergeron's
 * Verification Guild[1].  The original example is a non-synthesizable
 * behavioral model written in Verilog-1995 of a quad Asynchronous
 * Transfer Mode (ATM) user-to-network interface and forwarding node.
 * This example modifies the original code to be synthesizable, using
 * SystemVerilog constructs.  Also, the model has been made to be
 * configurable, so that it can be easily scaled from a 4x4 quad switch
 * to a 16x16 switch, or any other desired configuration.  The example,
 * including a nominal test bench, is partitioned into 8 files,
 * numbered 10.xx.xx_example_10-1.sv through 10-8.sv (where xx
 * represents section and subsection numbers in the book "SystemVerilog
 * for Design" (first edition).  The file 10.00.00_example_top.sv
 * includes all of the other files.  Simulation only needs to be
 * invoked on this one file.  Conditional compilation switches (`ifdef)
 * is used to compile the examples for simulation or for synthesis.
 *
 * [1] The Verification Guild is an independent e-mail newsletter and
 * moderated discussion forum on hardware verification.  Information on
 * the original Verification Guild example can be found at
 * www.janick.bergeron.com/guild/project.html.
 *
 * Used with permission in the book, "SystemVerilog for Design"
 *  By Stuart Sutherland, Simon Davidmann, and Peter Flake.
 *  Book copyright: 2003, Kluwer Academic Publishers, Norwell, MA, USA
 *  www.wkap.il, ISBN: 0-4020-7530-8
 *
 * Revision History:
 *   1.00 15 Dec 2003 -- original code, as included in book
 *   1.01 10 Jul 2004 -- cleaned up comments, added expected results
 *                       to output messages
 *   1.10 21 Jul 2004 -- corrected errata as printed in the book
 *                       "SystemVerilog for Design" (first edition) and
 *                       to bring the example into conformance with the
 *                       final Accellera SystemVerilog 3.1a standard
 *                       (for a description of changes, see the file
 *                       "errata_SV-Design-book_26-Jul-2004.txt")
 *
 * Caveat: Expected results displayed for this code example are based
 * on an interpretation of the SystemVerilog 3.1 standard by the code
 * author or authors.  At the time of writing, official SystemVerilog
 * validation suites were not available to validate the example.
 *
 * RIGHT TO USE: This code example, or any portion thereof, may be
 * used and distributed without restriction, provided that this entire
 * comment block is included with the example.
 *
 * DISCLAIMER: THIS CODE EXAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY
 * OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED
 * TO WARRANTIES OF MERCHANTABILITY, FITNESS OR CORRECTNESS. IN NO
 * EVENT SHALL THE AUTHOR OR AUTHORS BE LIABLE FOR ANY DAMAGES,
 * INCLUDING INCIDENTAL OR CONSEQUENTIAL DAMAGES, ARISING OUT OF THE
 * USE OF THIS CODE.
 *********************************************************************/

// The following include file listed in the book text is in an example
// file that is included by 10.00.00_example_top.sv
//`include "methods.sv"

`include "definitions.sv"  // include external definitions
`include "uvm_environment.sv"

class Test extends uvm_test;
  `uvm_component_utils(Test)

  //---------------------------------------
  // environment instance 
  //---------------------------------------
  // Environment env;
  
  //---------------------------------------
  // atm_cell instance 
  //---------------------------------------
  UNI_cell atm_cell_test;

  // logic rst, clk;

  extern virtual  function void build_phase(uvm_phase phase);
  extern virtual  function void end_of_elaboration();
  extern          task          run_phase(uvm_phase phase);
  extern          function void report_phase(uvm_phase phase);
  extern          function      new(string name = "Test", uvm_component parent=null);

endclass //Test extends uvm_test

//--------------------------------------- 
// Constructor
//---------------------------------------
function Test::new(string name = "Test", uvm_component parent=null);
  super.new(name, parent);
endfunction


//--------------------------------------- 
// Build phase
//---------------------------------------
function void Test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  // #(parameter int NumRx = 4, parameter int NumTx = 4)
  // (Utopia.TB_Rx Rx[0:NumRx-1],
  //   Utopia.TB_Tx Tx[0:NumTx-1],
  //   cpu_ifc.Test mif,
  //   input logic rst, clk);
  //   super.build_phase(phase);

  // int NumRx = 4;
  // int NumTx = 4;
  // Utopia.TB_Rx Rx[0:NumRx-1];
  // Utopia.TB_Tx Tx[0:NumTx-1];
  // cpu_ifc.Test mif;
  // input logic rst, clk;  

  // Miscellaneous control interfaces
  // logic Initialized;

  // Create the environment
  // env = Environment::type_id::create(Rx, Tx, NumRx, NumTx, mif, "env", this);
  // env = Environment::type_id::create(null, null, null, null, null, "env", this);
  // Create the sequence
  // seq = add_sub_sequence::type_id::create("seq");

  // env = new(Rx, Tx, NumRx, NumTx, mif);

  atm_cell_test = new();

  $display("Simulation was run with conditional compilation settings of:");
  $display("`define TxPorts %0d", `TxPorts);
  $display("`define RxPorts %0d", `RxPorts);
  `ifdef FWDALL
    $display("`define FWDALL");
  `endif
  `ifdef SYNTHESIS
    $display("`define SYNTHESIS");
  `endif
  $display("");

  // env.gen_cfg();
  // env.build();
  // env.run();
  // env.wrap_up();

endfunction

//---------------------------------------
// end_of_elabaration phase
//---------------------------------------  
function void Test::end_of_elaboration();
  //print's the topology
  print();
endfunction

//--------------------------------------- 
// Run phase
//---------------------------------------
task Test::run_phase(uvm_phase phase);

  phase.raise_objection(this);
    atm_cell_test.print();
    // seq.start(env.agent.sequencer);
  phase.drop_objection(this);
  
  //set a drain-time for the environment if desired
  phase.phase_done.set_drain_time(this, 50);

endtask : run_phase


//---------------------------------------
// report phase
//---------------------------------------   
function void Test::report_phase(uvm_phase phase);
  uvm_report_server svr;
  super.report_phase(phase);
  
  svr = uvm_report_server::get_server();
  if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
    `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
    `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
  end
  else begin
    `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
    `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
  end
endfunction
