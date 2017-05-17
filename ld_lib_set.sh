#!/bin/bash
export LD_LIBRARY_PATH=$PWD/libraries/:$LD_LIBRARY_PATH

#gnome-terminal -e "bash -c \"!!; exec bash\"" echo $LD_LIBRARY_PATH & gnome-terminal & read -rsp $'Press any key to continue...\n' -n 1 key
gnome-terminal -x sh -c "echo ! $LD_LIBRARY_PATH;cd ./target_bin/bin; bash"

