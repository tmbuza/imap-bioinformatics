#!/bin/bash
# mothurSubsampleShared.sh

#!/bin/bash
# mothurCountShared.sh

# Creating basic variables

OUTDIR="mothur_process/otu_analysis"
DIST="sample.final.0.03.subsample.braycurtis.0.03.lt.dist"

LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

echo PROGRESS: Computing PCoA axes and loadings.

mothur "#set.logfile(name=${LOGS}/mothurPCoA.logfile);
    pcoa(phylip="${OUTDIR}"/"${DIST}")"

