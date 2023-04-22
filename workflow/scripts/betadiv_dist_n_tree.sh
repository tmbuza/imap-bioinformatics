#!/bin/bash

OUTDIR="mothur_process/otu_analysis"
SHARED="sample.final.shared"
SUBSHARED="sample.final.0.03.subsample.shared"
BETA=sharedsobs-braycurtis
DIST="sample.final.0.03.subsample.braycurtis.0.03.lt.dist"


LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name=${LOGS}/mothurBeta.logfile);
    dist.shared(shared = "${OUTDIR}"/"${SUBSHARED}", calc="${BETA}", subsample="${READCOUNT}")"

mothur "#set.logfile(name=${LOGS}/mothurSampleTree.logfile);
    tree.shared(phylip="${OUTDIR}"/"${DIST}")"


