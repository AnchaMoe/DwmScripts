#!/bin/bash

function NetInfo_Get {
	NetInterface=`ip route get 8.8.8.8 | awk '{print $5}'`
	NetReceive=`cat /proc/net/dev | grep $NetInterface | awk '{print $2}'`
	NetTransmit=`cat /proc/net/dev | grep $NetInterface | awk '{print $10}'`
}



function NetInfo_Refresh {
	Old_NetReceive=$NetReceive
	Old_NetTransmit=$NetTransmit
}



function NetInfo_Compute {
	local Value=$1
	local Old_Value=$2
	local Difference=$((Value-Old_Value))
	if [ $Difference -lt 1048576 ]; then
		echo "`echo "$Difference" | awk '{printf"%.2f",$1/1024}'`KB/s"
	else
		echo "`echo "$Difference" | awk '{printf"%.2f",$1/1024/1024}'`MB/s"
	fi
}



# Delete "#" in function if you want to use this function alone.
function NetInfo {
#	NetInfo_Refresh
#	NetInfo_Get
	echo "⬇`NetInfo_Compute $NetReceive $Old_NetReceive` ⬆`NetInfo_Compute $NetTransmit $Old_NetTransmit`"
}
