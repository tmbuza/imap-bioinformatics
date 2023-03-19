#!/usr/bin/env bash

OUTDIR="data/mothur/process"

###############
echo PROGRESS: Cleaning up working directory.
###############

mkdir -p "${OUTDIR}"/intermediate/

mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/