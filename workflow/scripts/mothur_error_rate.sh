#! /bin/bash

OUTDIR="mothur_process/error_analysis"
LOGS="mothur_process/error_analysis/logs"

FASTA="mothur_process/error_analysis/final.fasta"
COUNTTABLE="mothur_process/error_analysis/final.count_table"

MOCKV4="data/references/zymo.mock.16S.v4.fasta"
MOCKGROUPS=Mock1

MOCKFASTA="mothur_process/error_analysis/final.pick.fasta"
MOCKCOUNT="mothur_process/error_analysis/final.pick.count_table"


##########################
echo PROGRESS: Calculating sequencing error rate in reference to Zymo mock reference.
##########################

mkdir -p \
	"${OUTDIR}" \
	"${LOGS}"

mothur "#set.logfile(name=${LOGS}/error_rate.logfile);
    get.groups(fasta="${FASTA}", count="${COUNTTABLE}", groups="${MOCKGROUPS}");
    seq.error(fasta="${MOCKFASTA}", count="${MOCKCOUNT}", reference="${MOCKV4}", aligned=F)"
