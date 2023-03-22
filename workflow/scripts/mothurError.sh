#! /bin/bash

ERRORFASTA="mothur_process/error_analysis/errorinput.fasta"
ERRORCOUNT="mothur_process/error_analysis/errorinput.count_table"
MOCKV4="data/references/zymo.mock.16S.v4.fasta"
MOCKGROUPS=Mock1

MOCKFASTA="mothur_process/error_analysis/errorinput.pick.fasta"
MOCKCOUNT="mothur_process/error_analysis/errorinput.pick.count_table"

OUTDIR=data/mothur/process
LOGS="data/mothur/logs"

##########################
echo PROGRESS: Calculating sequencing error rate in reference to Zymo reference sequences.
##########################

mothur "#set.logfile(name=${LOGS}/error_rate.logfile);
    get.groups(fasta="${ERRORFASTA}", count="${ERRORCOUNT}", groups="${MOCKGROUPS}");
    seq.error(fasta="${MOCKFASTA}", count="${MOCKCOUNT}", reference="${MOCKV4}", aligned=F)"
