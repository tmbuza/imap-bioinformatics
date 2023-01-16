#! /bin/bash

# denoise_n_classify.sh

CLASSIFIER="trainset16_022016.pds.fasta"
TAXONOMY="trainset16_022016.pds.tax"

OUTDIR="data/mothur/process"
DBREFSDIR="data/mothur/references"

FASTA="test.trim.contigs.good.unique.good.filter.unique.fasta"
COUNT="test.trim.contigs.good.unique.good.filter.count_table"

LOGS="data/mothur/logs"

echo PROGRESS: Aligning and filtering bad alignments.

mkdir -p "${OUTDIR}" 
	
mothur "#
    set.logfile(name=${LOGS}/denoise_n_classify.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, count=${OUTDIR}/${COUNT});

	pre.cluster(fasta=current, count=current, diffs=2);

	set.logfile(name=name=${LOGS}/chimera_removal.logfile);
	chimera.vsearch(fasta=current, count=current, dereplicate=t);

	set.logfile(name=name=${LOGS}/classify_seq.logfile);
	classify.seqs(fasta=current, count=current, reference=${DBREFSDIR}/${CLASSIFIER}, taxonomy=${DBREFSDIR}/${TAXONOMY}, cutoff=97);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
  
    set.logfile(name=${LOGS}/cluster_n_classify.logfile);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"

	
# Renaming output files for use later
# mv ${OUTDIR}/*.precluster*pick.fasta ${ERRORDIR}/errorinput.fasta
# mv ${OUTDIR}/*.vsearch*.pick.count_table ${ERRORDIR}"/errorinput.count_table
mv "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
mv "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
mv "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
mv "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
mv "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table
mv "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
mv "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/

# # # Deleting unneccessary files
# rm "${OUTDIR}"/*filter.unique.precluster*fasta
rm "${OUTDIR}"/*.map
# rm "${OUTDIR}"/*filter.unique.precluster*count_table

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/

# mv "${OUTDIR}"/current_files.summary ${LOGS}/current_saved_files.logfile
