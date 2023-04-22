#!/bin/bash

OUTDIR="mothur_process/otu_analysis"
SHARED="sample.final.shared"

LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

echo PROGRESS: Getting group count

mothur "#set.logfile(name=${LOGS}/mothurCountGroups.logfile);
    count.groups(shared="${OUTDIR}"/"${SHARED}")"
