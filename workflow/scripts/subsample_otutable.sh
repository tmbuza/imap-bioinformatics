#! /bin/bash
# subsample_otutable.sh

# Set the variables to be used in this script
OTUANALYSISDIR="data/mothur/final/otu_analysis" 
SAMPLESHARED="sample.final.shared" # Shared file to be counted
MOCKSHARED="mock.final.shared" # Shared file to be counted
CONTROLSHARED="control.final.shared" # Shared file to be counted

SAMPLECOUNT="sample.final.count.summary"
MOCKCOUNT="mock.final.count.summary"
CONTROLCOUNT="control.final.count.summary"

SUBTHRESH=10
LOGS="data/mothur/logs"

############################
# Subsampling Shared Files #
############################

# Subsampling reads based on count tables
echo PROGRESS: Subsampling shared file.

# Pulling smallest number of reads greater than or equal to $SUBTHRESH for use in subsampling 
SAMPLEREADCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${OTUANALYSISDIR}/${SAMPLECOUNT="sample.final.count.summary"
}" | sort -n | head -n 1)

MOCKREADCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${OTUANALYSISDIR}/${MOCKCOUNT="mock.final.count.summary"
}" | sort -n | head -n 1)

CONTROLREADCOUNT=$(awk -v SUBTHRESH="${SUBTHRESH}" '$2 >= SUBTHRESH { print $2}' "${OTUANALYSISDIR}/${CONTROLCOUNT="control.final.count.summary"
}" | sort -n | head -n 1)

# Debugging message
echo PROGRESS: Subsampling to "${SAMPLEREADCOUNT}" reads.

# Subsampling reads based on $READCOUNT
mothur "#set.logfile(name=${LOGS}/subsampling_sample.logfile);
    sub.sample(shared="${OTUANALYSISDIR}"/"${SAMPLESHARED}", size="${SAMPLEREADCOUNT}")"

mothur "#set.logfile(name=${LOGS}/subsampling_mock.logfile);
    sub.sample(shared="${OTUANALYSISDIR}"/"${MOCKCOUNT}", size="${MOCKREADCOUNT}")"

mothur "#set.logfile(name=${LOGS}/subsampling_control.logfile);
    sub.sample(shared="${OTUANALYSISDIR}"/"${CONTROLSHARED}", size="${CONTROLREADCOUNT}")"