#! /bin/bash

REFSDIR="data/mothur/references" # Directory for storing mothur reference files

echo PROGRESS: Preparing Mothur-based RPD taxonomy files.

# Making reference output directory
mkdir -p "${REFSDIR}"/ "${REFSDIR}"/tmp/


# For more information see https://mothur.org/wiki/rdp_reference_files/
curl -L -R -o "${REFSDIR}"/tmp/trainset16_022016.pds.tgz -z "${REFSDIR}"/tmp/trainset16_022016.pds.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset16_022016.pds.tgz

# Decompressing the database
tar -xvzf "${REFSDIR}"/tmp/trainset16_022016.pds.tgz -C "${REFSDIR}"/tmp/

# Move the taxonomy files out of the tmp dir
mv "${REFSDIR}"/tmp/trainset16_022016.pds/trainset16_022016* "${REFSDIR}"/

# Cleaning up reference dir
rm -rf "${REFSDIR}"/tmp/
