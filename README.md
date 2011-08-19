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
	cd /usr/local && git checkout -b local
	
### Per User install

Open GIT Bash and issue the following commands

	git clone -b windows git://github.com/joerg/LabViewGitEnv.git /tmp/LabViewGitEnv
	find /tmp/LabViewGitEnv -maxdepth 1 -mindepth 1 -exec cp -r {} ~ \;
	cd ~ && git checkout -b local

Linux and Mac
-------------

Work on this is not done yet, but I suppose it should be pretty simple to do so. If you are using LabView on Linux or Mac and want to use it with GIT then please contact me and we can surely figure this out pretty fast.

Update LabViewGitEnv
--------------------

To update you just have to open a GIT Bash, go to the folder you installed it to ( /usr/local for system wide installs, ~ for per user installs ) and issue the following commands

	git stash save "local changes"
	git checkout windows
	git pull
	git checkout local
	git rebase windows local
	git stash pop

Configure GIT to use LabViewGitEnv
==================================

To configure GIT to use LabViewGitEnv just open Git Bash on Windows or any Shell on Linux and Mac and issue the following

	InitLV.sh OPTION

where OPTION can be one of the following

	--system
Cofigures GIT system wide. You need administrative rights to do that, so on Windows you need to have Git Bash opened as Administrator and on Linux and Mac you have to be root or use sudo. This is recommended since GIT will be configured to only use LabViewGitEnv for LabView file types.

	--global
Configures user specific settings.

	--local
Configures the Repository you are currently in. Beware: This does not get propagated through a push/pull.

You may also need to edit you LabView path. To do so edit your LabViewConfig.sh in either /usr/local/etc or ~/etc and adapt the LabViewBin and LabViewShared variables. LabViewBin represents the LabView binary you want to use, LabViewShared represents the folder where to find LabVIEW Compare and LabVIEW Merge.
If you can't find those two you may use the following commands to search through your system (replace the "c" with whatever drive letter your LabView is installed on)

	find /c -type f -name LabVIEW.exe -print 2> /dev/null
	find /c -type d -name "LabVIEW Compare" -print 2> /dev/null

The first one will search for your LabViewBin, the second one will search for your LabViewShared (be sure to only use the part of the path till the Shared folder).

Example usage
=============

Assuming you have a `master` branch with a few commits and `feature` branch and you have currently checked out `master`. Calling

	git diff feature

will bring up [LVCompare.exe](http://zone.ni.com/reference/en-XX/help/371361G-01/lvhowto/configlvcomp_thirdparty/) with the correct attributes and show you the differences between `master` and `feature`. To merge those branches you can use

	git merge feature

which will bring up [LVMerge.exe](http://zone.ni.com/reference/en-XX/help/371361G-01/lvhowto/configmerge_thirdparty/). This will show you 4 different versions: Base, which is the common ancestor of `feature` and `master`, Theirs which is the vi in `feature`, Yours, which is the vi in `master` and finally the merged vi. Just edit the merged vi if necessary, save it and press close and GIT will automagically create a nice merge commit.
Attention: When calling

	git merge feature master

GIT will not call LVMerge.exe at first but will try to do an internal merge which will fail. You will then have to use

	git mergetool -t labview

to call LVMerge.exe and do the merge.

Copyright
=========

Copyright (c) 2011 Jörg Herzinger, see LICENSE for details.
