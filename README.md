# vfsd-utopia
This project is adapted from the one in the book "SystemVerilog for Verification: A Guide to Learning the Testbench Language Features", by CHRIS SPEAR (Springer, 2012). Files were download from author's website (http://www.chris.spear.net/systemverilog/default.htm) and modified to run into Mentor's ModelSim tool (command line mode - not a project!). We intend to add instructions for guiding you through the compilation process in the future. File names were preserved, so copyright information can be tracked back to original files.

---

VFSD-Utopia - Darlan

Para executar a verificação UVM:

No QuestaSim/ModelSim navegue para o diretório: \vfsd-utopia

Execute o comando: do scripts/3_simul.do

Existem agentes passivos e ativos, porém o monitor ativo não está corretemnte implementado (não conforma com o protocolo do DUT para a captura de dados.)
O Scoreboard está implementado com 2 filas de entrada, uma para todos os agentes passivos e outra para todos os agente ativos mas não há lógica de verificação no scoreboard.

Há controle de verbosidade explícita com o uso de +UVM_VERBOSITY=LOW/+UVM_VERBOSITY=HIGH no comando de simulação (ver linha 22 do arquivo scripts/1_compile.do).
