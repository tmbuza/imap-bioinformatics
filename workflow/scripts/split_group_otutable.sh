#! /bin/bash

# split_group_otutable.sh


MOCKGROUPS="Mock1-Mock2-Mock3" # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS="Water1-Water2-Water3" # List of control groups in raw data dir separated by '-'
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'

FINALDIR="data/mothur/final"
LOGS="data/mothur/logs"


# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#set.logfile(name=${LOGS}/split_group_otutable.logfile);
remove.groups(shared="${FINALDIR}"/final.shared, groups="${COMBINEDGROUPS}")"
mv "${FINALDIR}"/final.0.03.pick.shared "${FINALDIR}"/sample.final.shared


# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#get.groups(shared="${FINALDIR}"/final.shared, groups="${MOCKGROUPS}")"
mv "${FINALDIR}"/final.0.03.pick.shared "${FINALDIR}"/mock.final.shared

# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#get.groups(shared="${FINALDIR}"/final.shared, groups="${CONTROLGROUPS}")"
mv "${FINALDIR}"/final.0.03.pick.shared "${FINALDIR}"/control.final.shared
