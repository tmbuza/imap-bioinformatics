#! /bin/bash

# classify_otu97.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

MCCLIST="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.list"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"
TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy"
FASTA="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta"

echo PROGRESS: Generating the OTU table, the shared file.

mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/classify_otu97.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, list=${OUTDIR}/${MCCLIST}, count=${OUTDIR}/${COUNT}, taxonomy=${OUTDIR}/${TAXONOMY});

	make.shared(list=current, count=current, label=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);

	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);

	set.logfile(name=${LOGS}/get_repfasta_repcount.logfile);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);"
