#! /bin/bash

# classify_phylotype.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

FASTA="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta"

echo PROGRESS: Generating phylip tree from the final rep fasta
mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/classify_phylogeny.logfile);
	set.current(fasta=${OUTDIR}/${FASTA});

	dist.seqs(fasta=current, output=lt, inputdir=${OUTDIR}, outputdir=${OUTDIR});
    clearcut(phylip=current)"
