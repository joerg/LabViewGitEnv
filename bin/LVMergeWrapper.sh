#!/bin/bash

# Read System wide config
if [ -e /usr/local/etc/LVConfig.sh ]
then
	source /usr/local/etc/LVConfig.sh
fi
# Read User Config
if [ -e ~/etc/LVConfig.sh ]
then
	source ~/etc/LVConfig.sh
fi
# Read Local Config
if [ -e ./LVConfig.sh ]
then
	source ./LVConfig.sh
fi

BASE="${WD}\\$(echo "$2" | sed -e "${TRAILFIX}")"
LOCAL="${WD}\\$(echo "$3" | sed -e "${TRAILFIX}")"
REMOTE="${WD}\\$(echo "$4" | sed -e  "${TRAILFIX}")"
MERGED=$LOCAL

# Execute Compare
"${LabViewShared}/LabVIEW Merge/LVMerge.exe" "${LabViewBin}" "${BASE}" "${LOCAL}" "${REMOTE}" "${MERGED}"

while true; do
    read -p "Was the merge successful (yes/no)?" yn
    case $yn in
        [Yy]* ) echo "Merge successful."; exit 0;;
        [Nn]* ) echo "Merge unsuccessful. Please fix with 'git mergetool -t labview'"; exit 255;;
        * ) echo "Please answer yes or no.";;
    esac
done
