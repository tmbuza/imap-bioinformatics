#! /bin/bash

# Creating basic variables
# SAMPLEDIR="data/mothur/raw"
SAMPLEDIR="/Volumes/SeagateTMB/MOTHUR_BUSHMEAT/SRR7450/data/reads/"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

echo PROGRESS: Making mothur-based sample mapping file.

mkdir -p "${OUTDIR}"  "${LOGS}"
mothur "#set.logfile(name=${LOGS}/make_files.logfile);
      make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}", prefix=bush);"
