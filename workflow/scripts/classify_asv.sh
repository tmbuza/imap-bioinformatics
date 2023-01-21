#! /bin/bash

# classify_asv.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"

echo PROGRESS: Generating asv shared table
mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/classify_asv.logfile);
	set.current(taxonomy=${OUTDIR}/${TAXONOMY}, count=${OUTDIR}/${COUNT});

	set.logfile(name=${LOGS}/make_asv_shared.logfile);
    make.shared(count=current);
    classify.otu(list=current, count=current, taxonomy=current, label=ASV);
    make.lefse(shared=current, constaxonomy=current);
    make.biom(shared=current, constaxonomy=current);"
