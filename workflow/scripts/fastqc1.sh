#!/bin/bash

INPUTDIR=data/mothur/raw
OUTDIR=results/qc

mkdir -p "${OUTDIR}"

echo PRGRESS: Quality control using fastqc function.

fastqc ${INPUTDIR}/*.fastq.gz -o ${OUTDIR}/fastqc1
