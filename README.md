LabViewGitEnv
=============

This represents everything that is needed to hold your LabView projects under version control with GIT.
With this you can configure GIT to use LabViews diff and merge tools to play with your projects. Currently only .vi files are supported others may be coming soon.

Usage
=====

There are (or should be) four branches. The one you are seeing here (master) should be fairly empty, the other ones represent everything that is needed for linux, mac and windows.
In order to run this you will need LabView, GIT and bash which comes with msysgit for Windows users and should be preinstalled on any *nix system.

Usage on Windows
----------------

You can install this system wide or per user. If you have administrative rights I suggest installing it system wide.

### System wide install

Open GIT Bash as Administrator and issue the following commands

	mkdir -p /usr/local
	git clone -b windows git://github.com/joerg/LabViewGitEnv.git /usr/local/
	
### Per User install

Open GIT Bash and issue the following commands

	git clone -b windows git://github.com/joerg/LabViewGitEnv.git /tmp/LabViewGitEnv
	find /tmp/LabViewGitEnv -maxdepth 1 -mindepth 1 -exec cp -r {} ~ \;

Linux and Mac
-------------

Work on this is not done yet, but I suppose it should be pretty simple to do so. If you are using LabView on Linux or Mac and want to use it with GIT then please contact me and we can surely figure this out pretty fast.

Update LabViewGitEnv
--------------------

To update you just have to open a GIT Bash, go to the folder you installed it to ( /usr/local for system wide installs, ~ for per user installs ) and issue the following command

	git pull

Configure GIT to use LabViewGitEnv
==================================

To configure GIT to use LabViewGitEnv just open Git Bash on Windows or any Shell on Linux and Mac and issue the following

	InitLV OPTION

where OPTION can be one of the following

	--system
Cofigures GIT system wide. You need administrative rights to do that, so on Windows you need to have Git Bash opened as Administrator and on Linux and Mac you have to be root or use sudo. This is recommended since GIT will be configured to only use LabViewGitEnv for LabView file types.

	--global
Configures user specific settings.

	--local
Configures the Repository you are currently in. Beware: This does not get propagated through a push/pull.

You may also need to edit you LabView path. To do so edit your LabViewConfig.sh in either /usr/local/etc or ~/etc and adapt the LabViewBin and LabViewShared variables. LabViewBin represents the LabView binary you want to use, LabViewShared represents the folder where to find LabVIEW Compare and LabVIEW Merge.

Copyright
=========

Copyright (c) 2011 Jörg Herzinger.
