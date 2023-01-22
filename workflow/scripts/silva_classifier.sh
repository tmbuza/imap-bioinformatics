#! /bin/bash

 # Directory for storing mothur reference files
REFSDIR="data/mothur/references"
LOGS="data/mothur/logs"

echo PROGRESS: Preparing mothur reference files. 

# Making reference output directory
mkdir -p "${REFSDIR}"/ "${REFSDIR}"/tmp/


echo PROGRESS: Preparing SILVA classifiers. 

mothur "#set.logfile(name=${LOGS}/degap_silva_alignments.logfile);
    degap.seqs(fasta="${REFSDIR}"/silva.seed.align);
    degap.seqs(fasta="${REFSDIR}"/silva.v4.align)"


# Cleaning up reference dir
rm -rf "${REFSDIR}"/tmp/