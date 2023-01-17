#! /bin/bash
# format_files.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

echo PROGRESS: Formating file for downstream analysis

mkdir -p "${OUTDIR}"  "${LOGS}" 

mothur "#set.logfile(name=${LOGS}/format_files.logfile);"

# Renaming output files for use later
# mv ${OUTDIR}/*.precluster*pick.fasta ${ERRORDIR}/errorinput.fasta
# mv ${OUTDIR}/*.vsearch*.pick.count_table ${ERRORDIR}"/errorinput.count_table

mv "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
mv "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
mv "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
mv "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
mv "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table
mv "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
mv "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/

# # # Deleting unneccessary files
# rm "${OUTDIR}"/*filter.unique.precluster*fasta
rm "${OUTDIR}"/*.map
# rm "${OUTDIR}"/*filter.unique.precluster*count_table

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/${DATASET}* "${OUTDIR}"/intermediate/
