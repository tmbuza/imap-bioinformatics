#! /bin/bash


OUTDIR="data/mothur/references" # Directory for storing mothur reference files

####################################
# Preparing Mothur Reference Files #
####################################

echo PROGRESS: Preparing mothur reference files. 

# Making reference output directory
mkdir -p ${OUTDIR}/ ${OUTDIR}/tmp/

echo PROGRESS: Preparing mothur-based SILVA sequence alignments. For more inforamtion see https://mothur.org/wiki/silva_reference_files/
curl -L -R -o ${OUTDIR}/tmp/silva.seed_v138.tgz -z ${OUTDIR}/tmp/silva.seed_v138.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138.tgz

# Decompressing the database
tar -xvzf ${OUTDIR}/tmp/silva.seed_v138.tgz -C ${OUTDIR}/tmp/

# Using mothur to pull out bacterial sequences and only keep sequences from the v4 region of the 16S rRNA DNA region
mothur "#get.lineage(fasta=${OUTDIR}/tmp/silva.seed_v138.align, taxonomy=${OUTDIR}/tmp/silva.seed_v138.tax, taxon=Bacteria);
	pcr.seqs(fasta=current, start=11894, end=25319, keepdots=F, processors=8)"

# Renaming the final output files
mv ${OUTDIR}/tmp/silva.seed_v138.pick.align ${OUTDIR}/silva.seed.align
mv ${OUTDIR}/tmp/silva.seed_v138.pick.pcr.align ${OUTDIR}/silva.v4.align

# Cleaning up reference dir
rm -rf "${OUTDIR}"/tmp/
