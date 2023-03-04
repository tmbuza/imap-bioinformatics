#!/usr/bin/env bash
METADATA="data/metadata"
INPUTDIR="data/mothur/process"

mkdir -p resources

###############################
echo PROGRESS: Extracting resources for IMAP-PART3, and cleaning the directory
###############################

# Resources for IMAP-PART3
cp ${METADATA}/metadata.csv resources
cp config/samples.tsv resources
cp ${INPUTDIR}/final.shared resources
cp ${INPUTDIR}/sample.final.shared resources
cp ${INPUTDIR}/final.taxonomy resources
cp ${INPUTDIR}/final.lefse resources
cp ${INPUTDIR}/final.biom resources		
