#!/bin/bash
# mothurSubsampleShared.sh

#!/bin/bash
# mothurCountShared.sh

# Creating basic variables

OUTDIR="mothur_process/otu_analysis"
SHARED="sample.final.shared"
SUBSHARED="sample.final.0.03.subsample.shared"

LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

mothur "#set.logfile(name=${LOGS}/mothurRarefaction.logfile);
    rarefaction.single(shared="${OUTDIR}"/"${SHARED}", calc=sobs, freq=20)"
