#! /bin/bash

ERRORFASTA="data/mothur/process/error_analysis/errorinput.fasta"
ERRORCOUNT="data/mothur/process/error_analysis/errorinput.count_table"
MOCKV4="data/references/zymo.mock.16S.v4.fasta"
MOCKGROUPS=Mock1

MOCKFASTA="data/mothur/process/error_analysis/errorinput.pick.fasta"
MOCKCOUNT="data/mothur/process/error_analysis/errorinput.pick.count_table"

OUTDIR=data/mothur/process

##########################
echo PROGRESS: Calculating sequencing error rate in reference to Zymo reference sequences.
##########################

mothur "#get.groups(fasta="${ERRORFASTA}", count="${ERRORCOUNT}", groups="${MOCKGROUPS}")"

mothur "#seq.error(fasta="${MOCKFASTA}", count="${MOCKCOUNT}", reference="${MOCKV4}", aligned=F)"
