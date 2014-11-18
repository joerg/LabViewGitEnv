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

BASE="${WD}\\$(echo "$1" | sed -e "${TRAILFIX}")"
LOCAL="${WD}\\$(echo "$2" | sed -e "${TRAILFIX}")"
REMOTE="${WD}\\$(echo "$3" | sed -e  "${TRAILFIX}")"
MERGED=${REMOTE}

# Execute Compare
detect_labview_version "${BASE}"
fix_paths
"${LabViewShared}/LabVIEW Merge/LVMerge.exe" "${LabViewBin}" "${BASE}" "${REMOTE}" "${LOCAL}" "${MERGED}"

for i in {0..99}; do
    read -p "Was the merge successful (yes/no)?" yn
    case $yn in
        [Yy]* ) echo "Merge successful."; exit 0;;
        [Nn]* ) echo "Merge unsuccessful. Please fix with 'git mergetool -t labview'"; exit 255;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "It seems you either can't type or you are using gitk. For the latter "
echo "one I have no means of knowing whether the merge succeeded or not, "
echo "so I have to stop the merge and you have to commit it manually."

exit 255
