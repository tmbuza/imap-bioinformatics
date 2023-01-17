#! /bin/bash

# classify_seq97.sh

OUTDIR="data/mothur/process"

FASTA="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"
TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy"

LOGS="data/mothur/logs"

echo PROGRESS: Aligning and filtering bad alignments.

mkdir -p "${OUTDIR}" 
	
mothur "#
    set.logfile(name=${LOGS}/cluster_n_classify_otu.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, count=${OUTDIR}/${COUNT}, taxonomy=${OUTDIR}/${TAXONOMY});

	dist.seqs(fasta=current, cutoff=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	cluster(column=current, count=current);"