#! /bin/bash
# subsample_otutable.sh

# Set the variables to be used in this script

FINALDIR="data/mothur/final" 
SHARED="sample.final.shared"
COUNT="sample.final.count.summary"

SUBTHRESH=1000


############################
# Subsampling Shared Files #
############################

# Subsampling reads based on count tables
echo PROGRESS: Subsampling shared file.

# Pulling smallest number of reads greater than or equal to $SUBTHRESH for use in subsampling 
READCOUNT=$(awk -v SUBTHRESH="${FINALDIR}"/"${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${FINALDIR}"/"${COUNT}" | sort -n | head -n 1)

# Debugging message
echo PROGRESS: Subsampling to "${READCOUNT}" reads.

# Subsampling reads based on $READCOUNT
mothur "#set.logfile(name=${LOGS}/subsample_otutable.logfile);
    set.current(shared=${FINALDIR}/${SHARED});
    sub.sample(shared=current, size="${READCOUNT}", inputdir=${FINALDIR}, outputdir=${FINALDIR});"