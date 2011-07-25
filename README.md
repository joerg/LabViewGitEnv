LabViewEnv
==========

This represents everything that is needed to hold your LabView projects und version control with GIT.
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
	git clone git@github.com:joerg/LabViewGitEnv.git /usr/local/
	
### Per User install

Open GIT Bash and issue the following commands
	
	git clone git@github.com:joerg/LabViewGitEnv.git ~/

Linux and Mac
-------------

Work on this is not done yet, but I suppose it should be pretty simple to do so. If you are using LabView on Linux or Mac and want to use it with GIT then please contact me and we can surely figure this out pretty fast.


Copyright
=========

Copyright (c) 2011 Jörg Herzinger.
