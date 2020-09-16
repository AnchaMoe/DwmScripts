#!/bin/bash
# A system tray by "trayer".

killall trayer
if [ $? != 0 ]; then
	trayer --edge top --align right \
	--widthtype pixel --width 330 --heighttype pixel --height 30 \
	--SetPartialStrut true --transparent true \
	--alpha 180 --tint 0x66666666
fi
