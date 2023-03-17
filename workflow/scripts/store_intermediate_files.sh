#!/usr/bin/env bash

INPUTDIR="data/mothur/process"
OUTDIR="data/mothur/process/intermediate"

##############
echo PROGRESS: Cleaning up working directory.  
##############

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"

mv "${INPUTDIR}"/test* "${OUTDIR}"/intermediate/
