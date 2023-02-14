#! /bin/bash
# mothurSubsampleShared.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
SHARED="data/mothur/final/otu_analysis/sample.final.shared" # Shared file
COUNT="data/mothur/final/otu_analysis/sample.final.count.summary" # Count file generated from shared file
SUBTHRESH=1000 # Setting threshold for minimum number of reads to subsample



############################
# Subsampling Shared Files #
############################

# Subsampling reads based on count tables
echo PROGRESS: Subsampling shared file.

# Pulling smallest number of reads greater than or equal to $SUBTHRESH for use in subsampling 
READCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${COUNT}" | sort -n | head -n 1)

# Debugging message
echo PROGRESS: Subsampling to "${READCOUNT}" reads.

# Subsampling reads based on $READCOUNT
mothur "#sub.sample(shared="${SHARED}", size="${READCOUNT}")"
