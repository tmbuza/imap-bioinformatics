#! /bin/bash

# otutable_by_group.sh


MOCKGROUPS="Mock1-Mock2" # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS="Water1-Water2" # List of control groups in raw data dir separated by '-'
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'

OTUANALYSISDIR="data/mothur/final/otu_analysis"
LOGS="data/mothur/logs"


# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#set.logfile(name=${LOGS}/otutable_by_group.logfile);
remove.groups(shared="${OTUANALYSISDIR}"/final.shared, groups="${COMBINEDGROUPS}", outputdir=${OTUANALYSISDIR})"
mv "${OTUANALYSISDIR}"/final.0.03.pick.shared "${OTUANALYSISDIR}"/sample.final.shared


# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#get.groups(shared="${OTUANALYSISDIR}"/final.shared, groups="${MOCKGROUPS}")"
mv "${OTUANALYSISDIR}"/final.0.03.pick.shared "${OTUANALYSISDIR}"/mock.final.shared

# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#get.groups(shared="${OTUANALYSISDIR}"/final.shared, groups="${CONTROLGROUPS}")"
mv "${OTUANALYSISDIR}"/final.0.03.pick.shared "${OTUANALYSISDIR}"/control.final.shared
