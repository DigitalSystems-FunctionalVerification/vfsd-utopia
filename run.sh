#!/bin/bash
# module load modelsim
echo "	simulating... please wait"
# {
  #run vsim

  ~/Tools/questasim/linux_x86_64/vsim -novopt -c -do ./scripts/3_simul.do +UVM_PHASE_TRACE +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_LOW
  # ~/Tools/questasim/linux_x86_64/vsim -c -do ./scripts/3_simul.do
  # do wave.do

  #save log file
  mv transcript simulation.log

  #cleanup
  rm -rf *.ini transcript *.wlf work ./src/*~

# } > /dev/null
# module unload modelsim

