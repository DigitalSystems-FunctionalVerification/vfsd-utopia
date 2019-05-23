onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/soc}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/en}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/clav}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/valid}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/ready}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/reset}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/data}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/ATMcell}
add wave -noupdate -expand -group Rx_0 {/top/Rx[0]/selected}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/soc}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/en}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/clav}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/valid}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/ready}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/reset}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/data}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/ATMcell}
add wave -noupdate -expand -group Rx_1 {/top/Rx[1]/selected}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/soc}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/en}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/clav}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/valid}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/ready}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/reset}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/data}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/ATMcell}
add wave -noupdate -expand -group Rx_2 {/top/Rx[2]/selected}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/soc}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/en}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/clav}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/valid}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/ready}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/reset}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/data}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/ATMcell}
add wave -noupdate -expand -group Rx_3 {/top/Rx[3]/selected}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/soc}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/en}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/clav}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/valid}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/ready}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/reset}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/data}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/ATMcell}
add wave -noupdate -expand -group Tx_0 {/top/Tx[0]/selected}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/soc}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/en}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/clav}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/valid}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/ready}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/reset}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/data}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/ATMcell}
add wave -noupdate -expand -group Tx_1 {/top/Tx[1]/selected}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/soc}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/en}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/clav}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/valid}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/ready}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/reset}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/data}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/ATMcell}
add wave -noupdate -expand -group Tx_2 {/top/Tx[2]/selected}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/soc}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/en}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/clav}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/valid}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/ready}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/reset}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/data}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/ATMcell}
add wave -noupdate -expand -group Tx_3 {/top/Tx[3]/selected}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1965 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 671
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {10747 ns}
