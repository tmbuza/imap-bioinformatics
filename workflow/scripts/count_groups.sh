#! /bin/bash
# count_groups.sh

# Set the variables to be used in this script
OTUANALYSISDIR="data/mothur/final/otu_analysis" 
SAMPLESHARED="sample.final.shared" # Shared file to be counted
MOCKSHARED="mock.final.shared" # Shared file to be counted
CONTROLSHARED="control.final.shared" # Shared file to be counted

LOGS="data/mothur/logs"

#########################
# Counting Shared Files #
#########################

# Generating read count tables for shared files
echo PROGRESS: Generating read count tables.

# Counting each shared file individually
mothur "#count.groups(shared="${OTUANALYSISDIR}/${SAMPLESHARED}")"

mothur "#count.groups(shared="${OTUANALYSISDIR}/${MOCKSHARED}")"

mothur "#count.groups(shared="${OTUANALYSISDIR}/${CONTROLSHARED}")"