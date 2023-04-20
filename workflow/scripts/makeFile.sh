#! /bin/bash

SAMPLEDIR="data/reads"
OUTDIR="mothur_process"
LOGS="data/logs"

#----------------------
echo PROGRESS: Making mothur-based sample mapping file.
#----------------------

mkdir -p "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name=${LOGS}/makeFiles.logfile);
      make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}", prefix=test);"
