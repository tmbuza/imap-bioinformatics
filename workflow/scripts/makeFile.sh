#! /bin/bash

# Creating basic variables
# SAMPLEDIR="data/reads"
SAMPLEDIR="data/test"
OUTDIR="mothur_process"
LOGS="data/logs"

###############################
echo PROGRESS: Making mothur-based sample mapping file.
###############################

mkdir -p "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name=${LOGS}/makeFiles.logfile);
      make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}", prefix=test);"
