#! /bin/bash

# makealign_n_filter_contigs.sh
SILVAALIGN="silva.v4.align"

REFSDIR="data/mothur/references"

OUTDIR="data/mothur/process"
FASTA="test.trim.contigs.good.unique.fasta"
COUNT="test.trim.contigs.good.count_table"
LOGS="data/mothur/logs"


echo PROGRESS: Aligning and filtering bad alignments.

mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/align_n_filter.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, count=${OUTDIR}/${COUNT});
    align.seqs(fasta=current, reference=${REFSDIR}/${SILVAALIGN}, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	summary.seqs(fasta=current, count=current);	
	screen.seqs(fasta=current, count=current, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
	get.current()"


    # set.logfile(name=${LOGS}/precluster_n_chimera_removal.logfile);
    # pre.cluster(fasta=current, count=current, diffs=2);
	
	# summary.seqs(fasta=current, count=current);
	# screen.seqs(fasta=current, count=current, start=1251, end=13401, maxhomop=8);
	# filter.seqs(fasta=current, vertical=T, trump=.);
	# pre.cluster(fasta=current, count=current, diffs=2);
	# unique.seqs(fasta=current, count=current);

	# set.logfile(name=chimera_removal.logfile)
	# chimera.vsearch(fasta=current, count=current, dereplicate=t);

	# set.logfile(name=silva_seed_classification.logfile)
	# classify.seqs(fasta=current, count=current, reference=silva.seed_v138_1.align, taxonomy=silva.seed_v138_1.tax, cutoff=100);
	# remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);"

	# "rename.file(fasta=current, count=current, taxonomy=current, prefix=final)"
