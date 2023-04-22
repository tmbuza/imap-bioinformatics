#!/usr/bin/env bash

INPUTDIR="mothur_process"
OUTDIR="${INPUTDIR}"/intermediate

#----------------------
echo PROGRESS: Cleaning up working directory. Store intermediate files or you can decide to delete them later.
#----------------------
mkdir -p "${OUTDIR}"

mv "${INPUTDIR}"/test.trim.contigs.good.unique.good.filter.unique.precluster.*.count_table
mv "${INPUTDIR}"/test.trim.contigs.good.unique.good.filter.unique.precluster.*.fasta
mv "${INPUTDIR}"/test.trim.contigs.good.unique.good.filter.unique.precluster.*.map

mv "${INPUTDIR}"/test.conti* "${OUTDIR}"
mv "${INPUTDIR}"/test.trim* "${OUTDIR}"
