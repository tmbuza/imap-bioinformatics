#! /bin/bash

# classify_phylotype.sh

DATASET="test"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

TAXONOMY="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"

echo PROGRESS: Generating phylotype shared table
mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/classify_phylotype.logfile);
	set.current(taxonomy=${OUTDIR}/${TAXONOMY}, count=${OUTDIR}/${COUNT});
    
    phylotype(taxonomy=current);

	set.logfile(name=${LOGS}/make_phylo_shared.logfile);
	make.shared(list=current, count=current, label=1, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	classify.otu(list=current, count=current, taxonomy=current, label=1);

	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);
	get.current()"
