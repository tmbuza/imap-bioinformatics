#!/bin/bash
# mothurCountShared.sh

# Creating basic variables

OUTDIR="data/mothur/process"
SHARED="sample.final.shared"
LOGS="data/mothur/logs"

###############################
echo PROGRESS: Getting group count.
###############################

mkdir -p "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name=${LOGS}/mothurCountGroups.logfile);
    count.groups(shared="${OUTDIR}"/"${SHARED}")"