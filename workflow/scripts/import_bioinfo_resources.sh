#!/bin/bash

# Creating basic variables
INPUTDIR="../imap-requirements/resources"
OUTDIR="data"
# MAPPING="data/metadata"
# READSDIR="data/reads"
# TESTDIR="data/test"
# MOTHURREFS="data/references"
# MOCKCONTROL="data/mock_control"

###############################
echo PROGRESS: "Preparing resouces for Bioinformatics (IMAP-PART 2)"
###############################

mkdir -p "${OUTDIR}"

cp -r "${INPUTDIR}"/* "${OUTDIR}"/
# cp data/metadata/metadata.csv "${MAPPING}"/
# cp data/metadata/mothur_mapping.tsv "${MAPPING}"/
# cp data/metadata/mothur_design.tsv "${MAPPING}"/
# cp data/reads/*.fastq "${READSDIR}"/
# cp data/test/*_sub.fastq "${TESTDIR}"/
# cp data/mothur/references/* "${MOTHURREFS}"/
# cp data/mothur/references/* "${MOCKCONTROL}"/
