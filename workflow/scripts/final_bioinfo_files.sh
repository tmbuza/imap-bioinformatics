#! /bin/bash
# format_files.sh

DATASET="test"
OUTDIR="data/mothur/process"
FINALDIR="data/mothur/final"
LOGS="data/mothur/logs"
OTUANALYSIS="${FINALDIR}"/otu_analysis/
PHYLOTYPEANALYSIS="${FINALDIR}"/phylotype_analysis/
ERRORDIR="${FINALDIR}"/error_analysis/

echo PROGRESS: Formating file for downstream analysis

mkdir -p "${OUTDIR}"  "${LOGS}" "${FINALDIR}" "${OTUANALYSIS}" "${PHYLOTYPEANALYSIS}" "${ERRORDIR}"

mothur "#set.logfile(name=${LOGS}/final_files.logfile);"

# Renaming output files for use later
# For error analysis
cp "${OUTDIR}"/*.vsearch.pick.pick.fasta "${ERRORDIR}"/errorinput.fasta
cp "${OUTDIR}"/*.vsearch.pick.count_table "${ERRORDIR}"/errorinput.count_table

# For downstream OTU analysis
cp "${OUTDIR}"/*.opti_mcc.list "${OTUANALYSIS}"/final.list
cp "${OUTDIR}"/*.opti_mcc.steps "${OTUANALYSIS}"/final.steps
cp "${OUTDIR}"/*.opti_mcc.sensspec "${OTUANALYSIS}"/final.sensspec
cp "${OUTDIR}"/*.opti_mcc.shared "${OTUANALYSIS}"/final.shared
cp "${OUTDIR}"/*.0.03.cons.taxonomy "${OTUANALYSIS}"/final.cons.taxonomy
cp "${OUTDIR}"/*.0.03.cons.tax.summary "${OTUANALYSIS}"/final.cons.tax.summary
cp "${OUTDIR}"/*.0.03.rep.fasta "${OTUANALYSIS}"/final.rep.fasta
cp "${OUTDIR}"/*.0.03.rep.count_table "${OTUANALYSIS}"/final.rep.count_table
cp "${OUTDIR}"/*.0.03.lefse "${OTUANALYSIS}"/final.lefse
cp "${OUTDIR}"/*.0.03.biom "${OTUANALYSIS}"/final.biom

# For downstream phylotype analysis
cp "${OUTDIR}"/*.tx.list  "${PHYLOTYPEANALYSIS}"/final.tx.list
cp "${OUTDIR}"/*.tx.rabund  "${PHYLOTYPEANALYSIS}"/final.tx.rabund
cp "${OUTDIR}"/*.tx.sabund  "${PHYLOTYPEANALYSIS}"/final.tx.sabund
cp "${OUTDIR}"/*.tx.shared  "${PHYLOTYPEANALYSIS}"/final.tx.shared
cp "${OUTDIR}"/*.tx.1.cons.taxonomy  "${PHYLOTYPEANALYSIS}"/final.tx.cons.taxonomy
cp "${OUTDIR}"/*.tx.1.lefse  "${PHYLOTYPEANALYSIS}"/final.tx.lefse
cp "${OUTDIR}"/*.tx.1.biom  "${PHYLOTYPEANALYSIS}"/final.tx.biom

# ###############
# # Cleaning Up #
# ###############

# echo PROGRESS: Cleaning up working directory.

# # Making dir for storing intermediate files (can be deleted later)
# mkdir -p "${OUTDIR}"/intermediate/

# # Moving all remaining intermediate files to the intermediate dir
# mv "${OUTDIR}"/${DATASET}* "${OUTDIR}"/intermediate/
