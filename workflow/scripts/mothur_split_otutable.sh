#! /bin/bash


# Set the variables to be used in this script
MOCKGROUPS=Mock1 # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS=Mock1 # List of control groups in raw data dir separated by '-'
SHARED="final.opti_mcc.shared"

# Other variables
OUTDIR=mothur_process/otu_analysis
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'



####################################
# Make Group-Specific Shared Files #
####################################

# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#remove.groups(shared="${OUTDIR}"/"${SHARED}", groups="${COMBINEDGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.opti_mcc.0.03.pick.shared "${OUTDIR}"/sample.final.shared;


# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/"${SHARED}", groups="${MOCKGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.opti_mcc.0.03.pick.shared "${OUTDIR}"/mock.final.shared;


# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/"${SHARED}", groups="${CONTROLGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.opti_mcc.0.03.pick.shared "${OUTDIR}"/control.final.shared;
