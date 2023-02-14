#!/bin/bash

# Creating basic variables
SAMPLEDIR="data/mothur/reads"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

###############################
echo PROGRESS: Making mothur-based sample mapping file.
###############################

mkdir -p "${SAMPLEDIR}" "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name="${LOGS}"/get_read_data.logfile);"

cp data/mothur/raw/*.fastq.gz "${SAMPLEDIR}"/
