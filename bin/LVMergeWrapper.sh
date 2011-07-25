#!/bin/bash

# Read System wide config
if [ -e /usr/etc/LabViewConfig.sh ]
then
	source /usr/etc/LabViewConfig.sh
fi
# Read User Config
if [ -e ~/etc/LabViewConfig.sh ]
then
	source ~/etc/LabViewConfig.sh
fi
# Read Local Config
if [ -e ./LabViewConfig.sh ]
then
	source ./LabViewConfig.sh
fi

DIR="$(echo "$1" | sed -e "${PATHFIX}")\\"
BASE=${DIR}$(echo "$2" | sed -e "${TRAILFIX}")
LOCAL=${DIR}$(echo "$3" | sed -e "${TRAILFIX}")
REMOTE=${DIR}$(echo "$4" | sed -e  "${TRAILFIX}")
MERGED=$LOCAL

# Execute Compare
"${LabViewShared}/LabVIEW Merge/LVMerge.exe" "${LabViewBin}" ${BASE} ${LOCAL} ${REMOTE} ${MERGED}