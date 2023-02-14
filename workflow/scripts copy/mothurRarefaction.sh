#! /bin/bash
# mothurRarefaction.sh
# William L. Close
# Schloss Lab
# University of Michigan


# Set the variables to be used in this script


OUTDIR="data/mothur/process"
SHARED="${OUTDIR}"/sample.final.shared

mkdir -p "${OUTDIR}"  "${LOGS}"

# Other settings
RAREFYOUTDIR=$(echo "${SHARED}" | sed 's:\(.*/\).*:\1:')



###########################
# Make Rarefaction Curves #
###########################

# Generating rarefaction files
echo PROGRESS: Generating rarefaction tables.

# Creating tmp directory for easier clean up and to avoid conflicts with rarefaction rabund files
TMP="${RAREFYOUTDIR}"/tmp_$(date +%s)/
mkdir -p "${TMP}"/

# Copying shared file to tmp directory so output files will be placed there
cp "${SHARED}" "${TMP}"/

# Finding path to shared file in new location
TMP_SHARED=$(echo "${SHARED}" | sed 's:'"${RAREFYOUTDIR}"':'"${TMP}"':')




# Moving output to main output dir
mv "${TMP}"/*groups*rarefaction "${RAREFYOUTDIR}"

# Cleaning up
rm -rf "${TMP}"/

# Calculating rarefaction curve data
mothur "#set.logfile(name=${LOGS}/mothurRarefaction.logfile);
    rarefaction.single(shared=f"${OUTDIR}"/"${SHARED}", calc=sobs, freq=100)"