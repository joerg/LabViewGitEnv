#!/bin/bash

OPT=$(echo $1 | tr "[:upper:]" "[:lower:]")
GIT_ATTR=$(cat ~/etc/LVGitAttributes.tpl 2>/dev/null || cat /usr/local/etc/LVGitAttributes.tpl 2>/dev/null)

source ~/etc/LVUtilities.sh 2>/dev/null || source /usr/local/etc/LVUtilities.sh 2>/dev/null

handle_options "${OPT}"
update_attributes "${GIT_ATTR}"
do_git_config "git config ${GIT_CONFIG_OPTS}"

