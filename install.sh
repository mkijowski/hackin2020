#!/bin/bash

echo "I'm not ready yet..."
WHOAMI=bah

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, exiting." 
   exit 1
fi

singularity_install() {
echo "Installing Go"
export VERSION=1.13.1 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

echo '
' >> ~/.bashrc
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    source ~/.bashrc

export VERSION=v3.6.3 && \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-$VERSION.tar.gz && \
    cd ./singularity && \
    ./mconfig && \
    make -C ./builddir && \
    make -C ./builddir install
}

home_config() {
    if [ ! -d /home/$WHOAMI/.singularity ]; then
	mkdir -p ~/.singularity
    fi


    if grep -q ghidra /home/$WHOAMI/.bashrc; then
	echo "Aliases already found, skipping."
    else
	echo "
alias ghidra=\"singularity exec ~/.singularity/r2ghidra.sif ghidra\"
alias r2=\"singularity exec ~/.singularity/r2ghidra.sif r2\"
alias avrdude=\"singularity exec ~/.singularity/avrdude.sif avrdude\"
alias qmk=\"singularity exec ~/.singularity/avrdude.sif qmk\"
" >> ~/.bashrc
    fi

}
export -f home_config

container_building() {
    if [ -f ./buildfiles/avrdude.build ]; then
	if [ -f /home/$WHOAMI/.singularity/avrdude.sif]; then
	    read -p "avrdude.sif exists, rebuild? (y/n):" avrconfirm
	else
	    singularity build /home/$WHOAMI/.singularity/avrdude.sif ./buildfiles/avrdude.build
	fi
	
	if [[ $avrconfirm == [yY] || $avrconfirm == [yY][eE][sS] ]]; then
	    rm /home/$WHOAMI/.singularity/avrdude.sif
	    singularity build /home/$WHOAMI/.singularity/avrdude.sif ./buildfiles/avrdude.build
	fi
    fi
    if [ -f ./buildfiles/r2ghidra.build ]; then
	if [ -f /home/$WHOAMI/.singularity/r2ghidra.sif]; then
	    read -p "r2ghidra.sif exists, rebuild? (y/n):" r2gconfirm
	else
	    singularity build /home/$WHOAMI/.singularity/r2ghidra.sif ./buildfiles/r2ghidra.build
	fi
	
	if [[ $r2gconfirm == [yY] || $r2gconfirm == [yY][eE][sS] ]]; then
	    rm /home/$WHOAMI/.singularity/r2ghidra.sif
	    singularity build /home/$WHOAMI/.singularity/r2ghidra.sif ./buildfiles/r2ghidra.build
	fi
    fi
}

