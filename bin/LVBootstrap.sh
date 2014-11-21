#!/bin/bash

OPT=$(echo $1 | tr "[:upper:]" "[:lower:]")
REPO_ROOT="$(pwd)"
REPO_ATTR=$(cat "${REPO_ROOT}/etc/LVGitAttributes.tpl")

source "${REPO_ROOT}/etc/LVUtilities.sh"

handle_options "${OPT}"
install_drivers "${REPO_ROOT}"
update_attributes "${REPO_ATTR}"
do_git_config "git config ${GIT_CONFIG_OPTS}"

