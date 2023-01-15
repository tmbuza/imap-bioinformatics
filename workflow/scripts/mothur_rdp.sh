#! /bin/bash

echo PROGRESS: Preparing Mothur-based RPD taxonomy files.

OUTDIR="data/mothur/references" # Directory for storing mothur reference files

# Making reference output directory
mkdir -p "${OUTDIR}"/ "${OUTDIR}"/tmp/


# For more information see https://mothur.org/wiki/rdp_reference_files/
curl -L -R -o "${OUTDIR}"/tmp/trainset16_022016.pds.tgz -z "${OUTDIR}"/tmp/trainset16_022016.pds.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset16_022016.pds.tgz

# Decompressing the database
tar -xvzf "${OUTDIR}"/tmp/trainset16_022016.pds.tgz -C "${OUTDIR}"/tmp/

# Move the taxonomy files out of the tmp dir
mv "${OUTDIR}"/tmp/trainset16_022016.pds/trainset16_022016* "${OUTDIR}"/

# Cleaning up reference dir
rm -rf "${OUTDIR}"/tmp/
