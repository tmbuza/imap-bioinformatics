#! /bin/bash

# get_otutable.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

MCCLIST="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"
TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy"
FASTA="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list"

echo PROGRESS: Generating the OTU table, the shared file.

mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/get_otutable.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, list=${OUTDIR}/${MCCLIST}, count=${OUTDIR}/${COUNT}, taxonomy=${OUTDIR}/${TAXONOMY});

	make.shared(list=current, count=current, label=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"
