#! /bin/bash
# format_files.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

echo PROGRESS: Formating file for downstream analysis

mkdir -p "${OUTDIR}"  "${LOGS}" 

mothur "#set.logfile(name=${LOGS}/reformat_files.logfile);"

# Renaming output files for use later
# mv ${OUTDIR}/*.precluster*pick.fasta ${ERRORDIR}/errorinput.fasta
# mv ${OUTDIR}/*.vsearch*.pick.count_table ${ERRORDIR}"/errorinput.count_table

cp "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
cp "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
cp "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
cp "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
cp "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.cons.taxonomy
cp "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.cons.tax.summary
cp "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
cp "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table
cp "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
cp "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom

###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/${DATASET}* "${OUTDIR}"/intermediate/
