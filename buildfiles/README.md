This is mostly old now.  Kijowski is still using it and the containers are pretty 
cool, but the install script does not work on the centos vm (not enough disk 
space, and I moved files around in the repo.

`./buildfiles` contains singularity build files to get the necessary software
installed (Ghidra, Radare2, AVRDUDE, QMK Toolbox).

`install.sh` will install singularity, build the necessary containers, move them
to `~/.singularity` and create aliases in `~/.bashrc` to execute the necessary
programs inside their respective containers.

