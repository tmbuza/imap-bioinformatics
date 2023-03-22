#!/bin/bash
# mothurSubsampleShared.sh

#!/bin/bash
# mothurCountShared.sh

# Creating basic variables

OUTDIR="mothur_process"
SHARED="sample.final.shared"
SUBSHARED="sample.final.0.03.subsample.shared"
COUNT="sample.final.count.summary"
ALPHA=nseqs-coverage-invsimpson-shannon-sobs 
BETA=sharedsobs-thetayc-braycurtis
SUBTHRESH=500
DIST="sample.final.braycurtis.0.03.lt.dist"


LOGS="mothur_process/logs"

mkdir -p "${OUTDIR}"  "${LOGS}"

# Subsampling reads based on count tables
echo PROGRESS: Subsampling shared file.

# Pulling smallest number of reads greater than or equal to $SUBTHRESH for use in subsampling 
READCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${OUTDIR}"/"${COUNT}" | sort -n | head -n 1)

# Debugging message
echo PROGRESS: Subsampling to "${READCOUNT}" reads.

# Subsampling reads based on $READCOUNT
mothur "#set.logfile(name=${LOGS}/mothurCountGroups.logfile);
    count.groups(shared="${OUTDIR}"/"${SHARED}")"

mothur "#set.logfile(name=${LOGS}/mothurSubsampleShared.logfile);
    sub.sample(shared="${OUTDIR}"/"${SHARED}", size="${READCOUNT}")"

mothur "#set.logfile(name=${LOGS}/mothurAlpha.logfile);
    summary.single(shared = "${OUTDIR}"/"${SHARED}", calc="${ALPHA}", subsample="${READCOUNT}")"

mothur "#set.logfile(name=${LOGS}/mothurRarefaction.logfile);
    rarefaction.single(shared="${OUTDIR}"/"${SHARED}", calc=sobs, freq=100)"

mothur "#set.logfile(name=${LOGS}/mothurBeta.logfile);
    dist.shared(shared = "${OUTDIR}"/"${SHARED}", calc="${BETA}", subsample="${READCOUNT}")"

mothur "#set.logfile(name=${LOGS}/mothurSampleTree.logfile);
    tree.shared(phylip="${OUTDIR}"/"${DIST}")"

mothur "#set.logfile(name=${LOGS}/mothurPCoA.logfile);
    pcoa(phylip="${OUTDIR}"/"${DIST}")"

mothur "#set.logfile(name=${LOGS}/mothurNMDS.logfile);
    nmds(phylip="${OUTDIR}"/"${DIST}", mindim=3, maxdim=3)"

