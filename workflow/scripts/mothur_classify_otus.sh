#!/usr/bin/env bash

OUTDIR="mothur_process/otu_analysis"
LOGS="mothur_process/otu_analysis/logs"

FASTA="mothur_process/otu_analysis/final.fasta"
COUNTTABLE="mothur_process/otu_analysis/final.count_table"

CLASSIFIER="data/references/trainset16_022016.pds.fasta"
TAXONOMY="data/references/trainset16_022016.pds.tax"

###############################
echo PROGRESS: OTU clustering.
###############################

# Making output dir
mkdir -p "${OUTDIR}" "${LOGS}"

# Processing and filtering 16S sequences
mothur "#set.logfile(name=${LOGS}/classify_otus.logfile);
	set.current(fasta="${FASTA}", count="${COUNTTABLE}");
   	classify.seqs(fasta=current, count=current, reference=${CLASSIFIER}, taxonomy=${TAXONOMY}, cutoff=80);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);


	set.logfile(name=${LOGS}/otu_clustering.logfile);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);


	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);
	get.current()"


