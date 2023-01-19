#! /bin/bash

# compute_seqdist003.sh

OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

FASTA="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"
TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy"


echo PROGRESS: Computing pairwise distances

mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/compute_seqdist003.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, count=${OUTDIR}/${COUNT}, taxonomy=${OUTDIR}/${TAXONOMY});
	dist.seqs(fasta=current, cutoff=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});"
