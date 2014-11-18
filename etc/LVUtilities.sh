#!/bin/bash

# Parse command line options in $1
function handle_options {
	case "$1" in
		--system)
			GIT_CONFIG_OPTS="--system"
			ATTRIBUTES_FILE=/etc/gitattributes
			ENV_ROOT=/usr/local
		;;
		--global)
			GIT_CONFIG_OPTS="--global"
			ATTRIBUTES_FILE=~/.gitattributes
			ENV_ROOT=~
		;;
		--local)
			git status &> /dev/null || { echo "You are not in a GIT Repository"; exit 0; }
			GIT_CONFIG_OPTS="--local"
			ATTRIBUTES_FILE=.git/info/attributes
			ENV_ROOT=~
		;;
		*) 
			echo -e "Usage: \"$0 option\" where option can be one of the following
--system - This will try to do a system wide configuration
--global - This will try to do a user configuration
--local - This will try to configure the local repository
anything else will print this text"
			exit 0;
	esac
}

# Install the scripts from directory $1
function install_drivers {
	REPO_ROOT_ABSOLUTE="$(echo $1)"
	ENV_ROOT_ABSOLUTE="$(echo ${ENV_ROOT})"
	mkdir -p "${ENV_ROOT_ABSOLUTE}/bin" "${ENV_ROOT_ABSOLUTE}/etc"

	cp "${REPO_ROOT_ABSOLUTE}/bin/LVCompareWrapper.sh" "${ENV_ROOT_ABSOLUTE}/bin"
	cp "${REPO_ROOT_ABSOLUTE}/bin/LVGitKExternalDiffWrapper.bat" "${ENV_ROOT_ABSOLUTE}/bin"
	cp "${REPO_ROOT_ABSOLUTE}/bin/LVMergeWrapper.sh" "${ENV_ROOT_ABSOLUTE}/bin"

	cp "${REPO_ROOT_ABSOLUTE}/etc/LVConfig.sh" "${ENV_ROOT_ABSOLUTE}/etc"
	cp "${REPO_ROOT_ABSOLUTE}/etc/LVDetect.sh" "${ENV_ROOT_ABSOLUTE}/etc"
}

# Update git attributes stored in $1
function update_attributes {
	CONT="$1"
	ATTRIBUTES_FILE_ABSOLUTE="$(echo ${ATTRIBUTES_FILE})"
	touch "${ATTRIBUTES_FILE_ABSOLUTE}"

	grep -q "${CONT}" "${ATTRIBUTES_FILE_ABSOLUTE}" || echo "${CONT}" >> "${ATTRIBUTES_FILE_ABSOLUTE}"
}

function do_git_config {
	$1 diff.labview.command "LVCompareWrapper.sh"
	$1 diff.labview.tool labview
	$1 diff.labview.guitool labview
	$1 difftool.labview.cmd "LVCompareWrapper.sh \"\${LOCAL}\" \"\${REMOTE}\""
	$1 difftool.labview.prompt false
	$1 merge.labview.tool labview
	$1 merge.labview.name "LabView Merge Driver"
	$1 merge.labview.driver "LVMergeWrapper.sh \"%O\" \"%B\" \"%A\""
	$1 mergetool.labview.cmd "LVMergeWrapper.sh \"\${BASE}\" \"\${REMOTE}\" \"\${LOCAL}\""
	$1 mergetool.labview.trustExitCode true
	if [ ${OPT} == "--global" ]
	then
		$1 core.attributesfile "${ATTRIBUTES_FILE}"
	fi
}

