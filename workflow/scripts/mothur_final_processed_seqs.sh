#!/usr/bin/env bash

INPUTDIR="mothur_process"

OTUDIR=${INPUTDIR}/otu_analysis
PHYLOTYPEDIR=${INPUTDIR}/phylotype_analysis
ASVDIR=${INPUTDIR}/asv_analysis
PHYLOGENYDIR=${INPUTDIR}/phylogeny_analysis
ERRORDIR=${INPUTDIR}/error_analysis

###############################
echo PROGRESS: Preparing for sequence classification
###############################

# Making output dir
mkdir -p \
	"${OTUDIR}" \
	"${PHYLOTYPEDIR}" \
	"${ASVDIR}" \
	"${PHYLOGENYDIR}" \
	"${ERRORDIR}" \
	"${LOGS}"


# Renaming output files for later use

# For OTU analysis
cp "${INPUTDIR}"/final* "${OTUDIR}"

# For Phylotype analysis
cp "${INPUTDIR}"/final* "${PHYLOTYPEDIR}"

# For ASV analysis
cp "${INPUTDIR}"/final* "${ASVDIR}"

# For Phylogeny analysis
cp "${INPUTDIR}"/final* "${PHYLOGENYDIR}"

# For error rate analysis
cp "${INPUTDIR}"/final* "${ERRORDIR}"


# # For downstream OTU analysis
# cp "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
# cp "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
# cp "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
# cp "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
# cp "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
# cp "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
# cp "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
# cp "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.count_table
# cp "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
# cp "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


