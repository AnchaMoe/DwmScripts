#!/bin/bash

function CpuInfo_Get {
	CpuLog=`cat /proc/stat | grep "cpu " | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}'`
	CpuIDLE=`echo "$CpuLog" | awk '{print $4}'`
	CpuTotal=`echo "$CpuLog" | awk '{print $1+$2+$3+$4+$5+$6+$7}'`
}



function CpuInfo_Refresh {
	Old_CpuLog=$CpuLog
	Old_CpuIDLE=$CpuIDLE
	Old_CpuTotal=$CpuTotal
}



function CpuInfo_Compute {
	local DifferenceIDLE=$((CpuIDLE-Old_CpuIDLE))
	local DifferenceTotal=$((CpuTotal-Old_CpuTotal))
	echo "CPU:`echo "$DifferenceIDLE $DifferenceTotal" | awk '{printf"%.2f",($2-$1)/$2*100}'`%"
}



# Delete "#" in function if you want to use this function alone.
function CpuInfo {
#	CpuInfo_Refresh
#	CpuInfo_Get
	echo "`CpuInfo_Compute`"
}
