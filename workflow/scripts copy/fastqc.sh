#!/bin/bash

INPUTDIR=data/mothur/reads
OUTDIR=results/qc

mkdir -p "${OUTDIR}" "${OUTDIR}"/seqkit1 "${OUTDIR}"/fastqc1 "${OUTDIR}"/multiqc1

echo PRGRESS: Checking statistics and quality of the reads.

seqkit stat "${INPUTDIR}"/*.fastq >"${OUTDIR}"/seqkit1/seqkit_stats.txt

fastqc "${INPUTDIR}"/*.fastq -o "${OUTDIR}"/fastqc1

multiqc -f --data-dir "${OUTDIR}"/fastqc1 -o "${OUTDIR}"/multiqc1 --export