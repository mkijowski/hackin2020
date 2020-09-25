#!/bin/bash

echo "I'm not ready yet..."

#mkdir -p ~/.singularity
echo "
alias ghidra="singularity exec ~/.singularity/r2ghidra.sif ghidra"
alias r2="singularity exec ~/.singularity/r2ghidra.sif r2"
alias avrdude="singularity exec ~/.singularity/avrdude.sif avrdude"
"
