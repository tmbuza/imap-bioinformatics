#!/bin/bash

INPUTDIR="data/mothur/reads"
OUTDIR="results/qc/fastqc1"

mkdir -p "${OUTDIR}"

echo PRGRESS: Quality control using fastqc function.

fastqc ${INPUTDIR}/*.fastq -o ${OUTDIR}
fastqc "data/mothur/reads/*.fastq -o results/qc/fastqc1