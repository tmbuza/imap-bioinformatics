#! /bin/bash

 # Directory for storing mothur reference files
REFSDIR="data/mothur/references"
LOGS="data/mothur/logs"

echo PROGRESS: Preparing mothur reference files. 

# Making reference output directory
mkdir -p "${REFSDIR}"/ "${REFSDIR}"/tmp/



echo PROGRESS: Preparing SILVA database v4 sequence alignment files. 

# Downloading the prepared SILVA database from the mothur website
# For more inforamtion see https://mothur.org/wiki/silva_reference_files/
curl -L -R -o "${REFSDIR}"/tmp/silva.seed_v138.tgz -z "${REFSDIR}"/tmp/silva.seed_v138.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138.tgz

# Decompressing the database
tar -xvzf "${REFSDIR}"/tmp/silva.seed_v138.tgz -C "${REFSDIR}"/tmp/

# Using mothur to pull out bacterial sequences and only keep sequences from the v4 region of the 16S rRNA DNA region
mothur "#set.logfile(name=${LOGS}/silva_alignments.logfile);
get.lineage(fasta="${REFSDIR}"/tmp/silva.seed_v138.align, taxonomy="${REFSDIR}"/tmp/silva.seed_v138.tax, taxon=Bacteria);
	pcr.seqs(fasta=current, start=11894, end=25319, keepdots=F, processors=8)"

# Renaming the final output files
mv "${REFSDIR}"/tmp/silva.seed_v138.pick.align "${REFSDIR}"/silva.seed.align
mv "${REFSDIR}"/tmp/silva.seed_v138.pick.pcr.align "${REFSDIR}"/silva.v4.align


# Cleaning up reference dir
rm -rf "${REFSDIR}"/tmp/