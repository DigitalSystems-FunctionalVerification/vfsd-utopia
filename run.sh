#!/bin/bash
# module load modelsim
echo "	simulating... please wait"
# {
  #run vsim

  vsim -novopt -c -do ./scripts/3_simul.do

  #save log file
  mv transcript simulation.log

  #cleanup
  rm -rf *.ini transcript *.wlf work ./src/*~

# } > /dev/null
# module unload modelsim

