#!/bin/bash
# module load modelsim
echo "	simulating... please wait"
# {
  #run vsim

  vsim -novopt -c -do ./scripts/3_simul.do +UVM_PHASE_TRACE +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_LOW

  #save log file
  mv transcript simulation.log

  #cleanup
  rm -rf *.ini transcript *.wlf work ./src/*~

# } > /dev/null
# module unload modelsim

