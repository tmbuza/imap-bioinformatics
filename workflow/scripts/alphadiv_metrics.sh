#!/bin/bash
# mothurSubsampleShared.sh

#!/bin/bash
# mothurCountShared.sh

# Creating basic variables

OUTDIR="mothur_process/otu_analysis"
SHARED="sample.final.shared"
SUBSHARED="sample.final.0.03.subsample.shared"
COUNT="sample.final.count.summary"
ALPHA=nseqs-coverage-sobs-chao-simpson-invsimpson-shannon
SUBTHRESH=20


LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

# Subsampling reads based on count tables
echo PROGRESS: Subsampling shared file.

# Pulling smallest number of reads greater than or equal to $SUBTHRESH for use in subsampling 
READCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${OUTDIR}"/"${COUNT}" | sort -n | head -n 1)

mothur "#set.logfile(name=${LOGS}/mothurAlpha.logfile);
    summary.single(shared = "${OUTDIR}"/"${SUBSHARED}", calc="${ALPHA}", subsample="${READCOUNT}")"

