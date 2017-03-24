#!/bin/bash
export LD_LIBRARY_PATH=$PWD/:$LD_LIBRARY_PATH

#gnome-terminal -e "bash -c \"!!; exec bash\"" echo $LD_LIBRARY_PATH & gnome-terminal & read -rsp $'Press any key to continue...\n' -n 1 key
x-terminal-emulator -x sh -c "echo $LD_LIBRARY_PATH; bash"

