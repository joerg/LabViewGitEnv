#!/bin/bash

# Return the year-based LabVIEW release associated with the file version in $1
function year_for_file_version {
	case "$1" in
		9.0)
			echo 2009
		;;
		10.0)
			echo 2010
		;;
		11.0)
			echo 2011
		;;
		12.0)
			echo 2012
		;;
		13.0)
			echo 2013
		;;
		14.0)
			echo 2014
		;;
		*)
			echo >&2 "ERROR: Unknown LabVIEW file version: $1";
			exit 0;
		;;
	esac
}

# Set LabViewBin to match or exceed the version used for VI in $1
function detect_labview_version {
	VIQueryVersion=VIQueryVersion
	CanDetectLV=$(which ${VIQueryVersion} 2>/dev/null)

	if [ -n "${CanDetectLV}" ]; then
		LVFileVersion="$(${VIQueryVersion} $(echo $1 | sed -e "${MKWINPATH}" | sed -e "${PATHFIX}"))"
		MinLVVersion=$(year_for_file_version ${LVFileVersion})

		for lvVersion in 2009 2010 2011 2012 2013 2014; do
			if [ -x "/c/Program Files/National Instruments/LabVIEW ${lvVersion}/LabVIEW.exe" ]; then
				LabViewBin="/c/Program Files/National Instruments/LabVIEW ${lvVersion}/LabVIEW.exe"
				LabViewShared="/c/Program Files/National Instruments/Shared"
				Is32BitLVOn64BitWindows=false
			elif [ -x "/c/Program Files (x86)/National Instruments/LabVIEW ${lvVersion}/LabVIEW.exe" ]; then
				LabViewBin="/c/Program Files (x86)/National Instruments/LabVIEW ${lvVersion}/LabVIEW.exe"
				LabViewShared="/c/Program Files (x86)/National Instruments/Shared"
				Is32BitLVOn64BitWindows=:
			fi

			if [ ${lvVersion} -ge ${MinLVVersion} ]; then
				break
			fi
		done
	else
		echo >&2 "INFO: I could detect the version of LabVIEW to use if VIKit were installed."
		echo >&2 "INFO: Using \"${LabViewBin}\" by default"
	fi
}

