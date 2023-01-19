#! /bin/bash

# cluster_otu97.sh

OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"

COLUMN="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.dist"
COUNT="test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table"


echo PROGRESS: Aligning and filtering bad alignments.

mkdir -p "${OUTDIR}" 
	
mothur "#set.logfile(name=${LOGS}/cluster_otu97.logfile);
	set.current(column=${OUTDIR}/${COLUMN}, count=${OUTDIR}/${COUNT});
	cluster(column=current, count=current);"
	

