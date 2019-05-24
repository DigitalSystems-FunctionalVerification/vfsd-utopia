vlib work
vmap work work

#vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/config.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/definitions.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_atm_cell.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/utopia.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_driver.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/cpu_ifc.sv
#vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/cpu_driver.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_environment.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_scoreboard.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_monitor.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_atm_sequence.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_atm_sequencer.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/LookupTable.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/dut/utopia1_atm_rx.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/dut/utopia1_atm_tx.sv  
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/dut/squat.sv 
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/tb/uvm_test.sv
vlog -work work -sv +incdir+./src/tb +incdir+./src/dut ./src/dut/top.sv 

vsim work.top -novopt +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_NONE
#vsim work.top -novopt +UVM_PHASE_TRACE +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_LOW
#vsim work.top -novopt +UVM_PHASE_TRACE +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_LOW +UVM_CONFIG_DB_TRACE
set NoQuitOnFinish 1
do ./wave.do