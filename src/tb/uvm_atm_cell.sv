/**********************************************************************
 * Definition of an ATM cell
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

`ifndef ATM_CELL__SV
`define ATM_CELL__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "definitions.sv"

virtual class BaseTr extends uvm_sequence_item;
  static int count;  // Number of instance created
  int id;            // Unique transaction id
	
	//---------------------------------------
	// Utility and Field macros
	//---------------------------------------
	`uvm_object_utils_begin(BaseTr)
		`uvm_field_int(count, 	UVM_ALL_ON)
		`uvm_field_int(id,    	UVM_ALL_ON)
	`uvm_object_utils_end

  function new(string name = "BaseTr_item");
		super.new(name);
	 	id = count++;
  endfunction

  pure virtual function void display(input string prefix="");
endclass // BaseTr

typedef class NNI_cell;


/////////////////////////////////////////////////////////////////////////////
// UNI Cell Format
/////////////////////////////////////////////////////////////////////////////
class UNI_cell extends BaseTr;
	// Physical fields
	rand bit        [3:0]  GFC;
	rand bit        [7:0]  VPI;
	rand bit        [15:0] VCI;
	rand bit               CLP;
	rand bit        [2:0]  PT;
			 bit        [7:0]  HEC;
	rand bit [0:47] [7:0]  Payload;

	// Meta-data fields
	static bit [7:0] syndrome[0:255];
	static bit syndrome_not_generated = 1;

	`uvm_object_utils_begin(UNI_cell)
		`uvm_field_int(GFC,											UVM_ALL_ON)
		`uvm_field_int(VPI,											UVM_ALL_ON)
		`uvm_field_int(VCI,											UVM_ALL_ON)
		`uvm_field_int(CLP,											UVM_ALL_ON)
		`uvm_field_int(PT,											UVM_ALL_ON)
		`uvm_field_int(HEC,											UVM_ALL_ON)
		`uvm_field_int(Payload,									UVM_ALL_ON)
		// `uvm_field_int(syndrome,								UVM_ALL_ON)
		// `uvm_field_int(syndrome_not_generated,	UVM_ALL_ON)
	`uvm_object_utils_end

	extern function new(string name = "UNI_cell_item");
	extern function void post_randomize();
	
	extern virtual function void display(input string prefix="");
	extern function NNI_cell to_NNI();
	extern function void generate_syndrome();
	extern function bit [7:0] hec (bit [31:0] hdr);
endclass : UNI_cell


//-----------------------------------------------------------------------------
function UNI_cell::new(string name = "UNI_cell_item");
	super.new(name);
	if (syndrome_not_generated)
	  generate_syndrome();
endfunction : new


//-----------------------------------------------------------------------------
// Compute the HEC value after all other data has been chosen
function void UNI_cell::post_randomize();
	HEC = hec({GFC, VPI, VCI, CLP, PT});
endfunction : post_randomize



//-----------------------------------------------------------------------------

function void UNI_cell::display(input string prefix="");
	UNI_cell p;

	$display("%sUNI id:%0d GFC=%x, VPI=%x, VCI=%x, CLP=%b, PT=%x, HEC=%x, Payload[0]=%x",
		 prefix, id, GFC, VPI, VCI, CLP, PT, HEC, Payload[0]);
	// this.pack(p);
	$write("%s", prefix);
	// foreach (p.Mem[i]) $write("%x ", p.Mem[i]); $display;
	//$write("%sUNI Payload=%x %x %x %x %x %x ...",
	//	  prefix, Payload[0], Payload[1], Payload[2], Payload[3], Payload[4], Payload[5]);
	foreach(Payload[i]) $write(" %x", Payload[i]);
	$display;
endfunction : display

//---------------------------------------------------------------------------
// Generate a NNI cell from an UNI cell - used in scoreboard
function NNI_cell UNI_cell::to_NNI();
	NNI_cell copy;
	this.copy(copy);
	return copy;
endfunction : to_NNI


//---------------------------------------------------------------------------
// Generate the syndome array, used to compute HEC
function void UNI_cell::generate_syndrome();
	bit [7:0] sndrm;
	for (int i = 0; i < 256; i = i + 1 ) begin
		sndrm = i;
		repeat (8) begin
			if (sndrm[7] === 1'b1)
			  sndrm = (sndrm << 1) ^ 8'h07;
			else
			  sndrm = sndrm << 1;
		end
		syndrome[i] = sndrm;
	end
	syndrome_not_generated = 0;
endfunction : generate_syndrome

//---------------------------------------------------------------------------
// Function to compute the HEC value
function bit [7:0] UNI_cell::hec (bit [31:0] hdr);
	hec = 8'h00;
	repeat (4) begin
		hec = syndrome[hec ^ hdr[31:24]];
		hdr = hdr << 8;
	end
	hec = hec ^ 8'h55;
endfunction : hec




/////////////////////////////////////////////////////////////////////////////
// NNI Cell Format
/////////////////////////////////////////////////////////////////////////////
class NNI_cell extends BaseTr;
	// Physical fields
	rand bit        [11:0] VPI;
	rand bit        [15:0] VCI;
	rand bit               CLP;
	rand bit        [2:0]  PT;
		   bit        [7:0]  HEC;
	rand bit [0:47] [7:0]  Payload;

	`uvm_object_utils_begin(NNI_cell)
		`uvm_field_int(VPI,			UVM_ALL_ON)
		`uvm_field_int(VCI,			UVM_ALL_ON)
		`uvm_field_int(CLP,			UVM_ALL_ON)
		`uvm_field_int(PT,			UVM_ALL_ON)
		`uvm_field_int(HEC,			UVM_ALL_ON)
		`uvm_field_int(Payload,	UVM_ALL_ON)
	`uvm_object_utils_end

	// Meta-data fields
	static bit [7:0] syndrome[0:255];
	static bit syndrome_not_generated = 1;

	extern function new();
	extern function void post_randomize();
	extern virtual function void display(input string prefix="");
	extern function void generate_syndrome();
	extern function bit [7:0] hec (bit [31:0] hdr);
endclass : NNI_cell


function NNI_cell::new();
	if (syndrome_not_generated)
	  generate_syndrome();
endfunction : new


//-----------------------------------------------------------------------------
// Compute the HEC value after all other data has been chosen
function void NNI_cell::post_randomize();
	HEC = hec({VPI, VCI, CLP, PT});
endfunction : post_randomize

function void NNI_cell::display(input string prefix="");
	// ATMCellType p;

	$display("%sNNI id:%0d VPI=%x, VCI=%x, CLP=%b, PT=%x, HEC=%x, Payload[0]=%x",
		 prefix, id, VPI, VCI, CLP, PT, HEC, Payload[0]);
	// this.pack(p);
	$write("%s", prefix);
	// foreach (p.Mem[i]) $write("%x ", p.Mem[i]); $display;
	// $write("%sUNI Payload=%x %x %x %x %x %x ...",
	$display;
endfunction : display

//---------------------------------------------------------------------------
// Generate the syndome array, used to compute HEC
function void NNI_cell::generate_syndrome();
   bit [7:0] sndrm;
   for (int i = 0; i < 256; i = i + 1 ) begin
      sndrm = i;
      repeat (8) begin
         if (sndrm[7] === 1'b1)
           sndrm = (sndrm << 1) ^ 8'h07;
         else
           sndrm = sndrm << 1;
      end
      syndrome[i] = sndrm;
   end
   syndrome_not_generated = 0;
endfunction : generate_syndrome

//---------------------------------------------------------------------------
// Function to compute the HEC value
function bit [7:0] NNI_cell::hec (bit [31:0] hdr);
	hec = 8'h00;
	repeat (4) begin
		hec = syndrome[hec ^ hdr[31:24]];
		hdr = hdr << 8;
	end
	hec = hec ^ 8'h55;
endfunction : hec


`endif // ATM_CELL__SV
