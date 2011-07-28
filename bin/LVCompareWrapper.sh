#!/bin/bash

# Read System wide config
if [ -e /usr/local/etc/LabViewConfig.sh ]
then
	source /usr/local/etc/LabViewConfig.sh
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

LOCAL=$(echo "$2" | sed -e "${PATHFIX}")
REMOTE=$(echo "$5" | sed -e  "${PATHFIX}")

# Check if absolute path and complete with working directory if not
echo "$LOCAL" | grep -qE $ABSPATH || LOCAL="${WD}\\${LOCAL}"
echo "$REMOTE" | grep -qE $ABSPATH || REMOTE="${WD}\\${REMOTE}"

# Execute Compare
"${LabViewShared}/LabVIEW Compare/LVCompare.exe" "${LOCAL}" "${REMOTE}" "-lvpath" "${LabViewBin}"
