#!/bin/bash
echo ====  load led_switch arg=$1========
if [ "$1" = "start" ]
then
	echo "start led_switch"
    /bin/led_switch
fi

