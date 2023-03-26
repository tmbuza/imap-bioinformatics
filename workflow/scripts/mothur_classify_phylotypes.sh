#!/usr/bin/env bash

OUTDIR="mothur_process/phylotype_analysis"
LOGS="mothur_process/phylotype_analysis/logs"

FASTA="mothur_process/phylotype_analysis/final.fasta"
COUNTTABLE="mothur_process/phylotype_analysis/final.count_table"

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


	set.logfile(name=${LOGS}/phylotype_clustering.logfile);
    phylotype(taxonomy=current);
    make.shared(list=current, count=current, label=1);
    classify.otu(list=current, count=current, taxonomy=current, label=1);

    make.lefse(shared=current, constaxonomy=current);
    make.biom(shared=current, constaxonomy=current);
    get.current()"


