#!/bin/bash

OUTDIR=results/qc

mkdir -p "${OUTDIR}"

echo PRGRESS: Quality control using fastqc function.

multiqc -f --data-dir ${OUTDIR}/fastqc1 -o ${OUTDIR}/multiqc1