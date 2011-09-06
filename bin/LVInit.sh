#!/bin/bash

OPT=$(echo $1 | tr "[:upper:]" "[:lower:]")

function do_git_config {
	$1 diff.labview.command "LVCompareWrapper.sh"
	$1 merge.labview.tool labview
	$1 merge.labview.name "LabView Merge Driver"
	$1 merge.labview.driver "LVMergeWrapper.sh \"%O\" \"%A\" \"%B\""
	$1 mergetool.labview.cmd "LVMergeWrapper.sh \"\$BASE\" \"\$LOCAL\" \"\$REMOTE\""
	$1 mergetool.labview.trustExitCode true
	if [ $OPT == "--global" ]
	then
		$1 core.attributesfile $ATTRIBUTES_FILE
	fi
}

case "$OPT" in
	--system)
		GIT_CONFIG_OPTS="--system"
		ATTRIBUTES_FILE=/etc/gitattributes
	;;
	--global)
		GIT_CONFIG_OPTS="--global"
		ATTRIBUTES_FILE=~/.gitattributes
	;;
	--local)
		git status &> /dev/null || { echo "You are not in a GIT Repository"; exit 0; }
		GIT_CONFIG_OPTS="--local"
		ATTRIBUTES_FILE=.git/info/attributes
	;;
	*) 
		echo -e "Usage: \"$0 option\" where option can be one of the following
--system - This will try to do a system wide configuration
--global - This will try to do a user configuration
--local - This will try to configure the local repository
anything else will print this text"
		exit 0;
esac

# Set git config
do_git_config "git config ${GIT_CONFIG_OPTS}"

# Create attributes file if missing and write specifics
ATTRIBUTES_FILE_ABSOLUTE=$(echo ${ATTRIBUTES_FILE})
touch ${ATTRIBUTES_FILE_ABSOLUTE}
echo -e "*.vi diff=labview mergetool=labview merge=labview\n" >> ${ATTRIBUTES_FILE_ABSOLUTE}
