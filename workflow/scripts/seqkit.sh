#!/bin/bash

INPUTDIR=data/mothur/reads
OUTDIR=results/qc/seqkit1

mkdir -p "${OUTDIR}"

echo PRGRESS: Computing read statistics using seqkit stat function.

seqkit stat ${INPUTDIR}/*.fastq > ${OUTDIR}/seqkit_stats.txt

