#!/bin/bash

echo "I'm not ready yet..."

export WHOAMI=user


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, exiting." 
   exit 1
fi
yum update -y
yum groupinstall -y 'Development Tools'
yum install -y \
   openssl-devel \
   libuuid-devel \
   libseccomp-devel \
   wget \
   git \
   vim \
   squashfs-tools \
   cryptsetup \
   gpgme

singularity_install() {
echo "Installing Go"
if [ ! -d /usr/local/go ]; then
export VERSION=1.13.1 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

echo '
' >> ~/.bashrc
    echo 'export PATH=/usr/local/go/bin:${PATH}' >> ~/.bashrc && \
    source ~/.bashrc
else
    export PATH=/usr/local/go/bin:${PATH}
fi

if [ ! -f /usr/local/bin/singularity ]; then
    export VERSION=3.6.3 && \
    tar -xzf singularity-$VERSION.tar.gz && \
    cd ./singularity && \
    ./mconfig && \
    make -C ./builddir && \
    make -C ./builddir install
    fi
}

home_config() {
    if [ ! -d /home/$WHOAMI/.singularity ]; then
	mkdir -p /home/$WHOAMI/.singularity
    fi

    if grep -q ghidra /home/$WHOAMI/.bashrc; then
	echo "Aliases already found, skipping."
    else
	echo "
alias ghidra=\"singularity exec ~/.singularity/r2ghidra.sif ghidra\"
alias r2=\"singularity exec ~/.singularity/r2ghidra.sif r2\"
alias avrdude=\"singularity exec ~/.singularity/avrdude.sif avrdude\"
alias qmk=\"singularity exec ~/.singularity/avrdude.sif qmk\"
" >> /home/$WHOAMI/.bashrc
    fi
}
export -f home_config

container_building() {
    if [ -f ./buildfiles/avrdude.build ]; then
	if [ -f /home/$WHOAMI/.singularity/avrdude.sif ]; then
	    read -p "avrdude.sif exists, rebuild? (y/n):" avrconfirm
	else
	    /usr/local/bin/singularity build /home/$WHOAMI/.singularity/avrdude.sif ./buildfiles/avrdude.build
	fi
	
	if [[ $avrconfirm == [yY] || $avrconfirm == [yY][eE][sS] ]]; then
	    rm /home/$WHOAMI/.singularity/avrdude.sif
	    /usr/local/bin/singularity build /home/$WHOAMI/.singularity/avrdude.sif ./buildfiles/avrdude.build
	fi
    fi
    if [ -f ./buildfiles/r2ghidra.build ]; then
	if [ -f /home/$WHOAMI/.singularity/r2ghidra.sif ]; then
	    read -p "r2ghidra.sif exists, rebuild? (y/n):" r2gconfirm
	else
	    /usr/local/bin/singularity build /home/$WHOAMI/.singularity/r2ghidra.sif ./buildfiles/r2ghidra.build
	fi
	
	if [[ $r2gconfirm == [yY] || $r2gconfirm == [yY][eE][sS] ]]; then
	    rm /home/$WHOAMI/.singularity/r2ghidra.sif
	    /usr/local/bin/singularity build /home/$WHOAMI/.singularity/r2ghidra.sif ./buildfiles/r2ghidra.build
	fi
    fi
}

su -m $WHOAMI -c "bash -c home_config"
singularity_install
container_building

