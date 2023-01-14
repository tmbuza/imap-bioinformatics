#! /bin/bash
# mothurCountShared.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
SHARED="data/mothur/process/final.shared" # Shared file to be counted



#########################
# Counting Shared Files #
#########################

# Generating read count tables for shared files
echo PROGRESS: Generating read count tables.

# Counting each shared file individually
mothur "#count.groups(shared="${SHARED}")"
