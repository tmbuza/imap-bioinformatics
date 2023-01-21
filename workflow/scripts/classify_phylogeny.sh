#! /bin/bash

# classify_phylotype.sh

DATASET="test"
OUTDIR="data/mothur/final/phylogeny_analysis"
LOGS="data/mothur/logs"

FASTA="data/mothur/final/otu_analysis/final.rep.fasta"

echo PROGRESS: Generating phylip tree fro the rep fasta
mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/classify_phylogeny.logfile);
	dist.seqs(fasta=${FASTA}, output=lt, outputdir=${OUTDIR});
    clearcut(phylip=current)"

# data/mothur/final/final.rep.phylip.dist
# data/mothur/final/final.rep.phylip.tre