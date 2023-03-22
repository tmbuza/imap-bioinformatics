#!/usr/bin/env bash

OUTDIR="mothur_process"

###############
echo PROGRESS: Cleaning up working directory.
###############

mkdir -p "${OUTDIR}"/intermediate/

mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/
mv "${OUTDIR}"/current_files.summary "${OUTDIR}"/intermediate/