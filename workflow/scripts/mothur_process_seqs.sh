#!/usr/bin/env bash

# Set the variables to be used in this script
# SAMPLEDIR="data/reads"
SAMPLEDIR="data/test"
OUTDIR="mothur_process"

LOGS=${OUTDIR}/logs

SILVAALIGN="data/references/silva.v4.align"
CLASSIFIER="data/references/trainset16_022016.pds.fasta"
TAXONOMY="data/references/trainset16_022016.pds.tax"

###############################
echo PROGRESS: Assembling and quality control
###############################

# Making output dir
mkdir -p \
	"${OUTDIR}" \
	"${LOGS}"

# Processing and filtering 16S sequences
mothur "#set.logfile(name=${LOGS}/make_files.logfile);
	make.file(type=gz, inputdir=${SAMPLEDIR}, outputdir=${OUTDIR}, prefix=test);
	
	set.logfile(name=${LOGS}/seq_assembly.logfile);
	set.current(file=current);
	make.contigs(file=current);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);

	set.logfile(name=${LOGS}/seq_align_precluster.logfile);
	set.current(fasta=current);
    align.seqs(fasta=current, reference=${SILVAALIGN});
    screen.seqs(fasta=current, count=current, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=2);


	set.logfile(name=${LOGS}/chimera_removal.logfile);
	set.current(fasta=current, count=current);
    chimera.vsearch(fasta=current, count=current, dereplicate=T);
 

	set.logfile(name=${LOGS}/remove_lineage.logfile);
	set.current(fasta=current, count=current);
   	classify.seqs(fasta=current, count=current, reference=${CLASSIFIER}, taxonomy=${TAXONOMY}, cutoff=80);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
	
	set.logfile(name=final_files.logfile);
	rename.file(fasta=current, count=current, taxonomy=current, prefix=final)"

   	# remove.seqs(fasta=current, accnos=current);
	# set.logfile(name=${LOGS}/otu_clustering.logfile);
	# dist.seqs(fasta=current, cutoff=0.03);
	# cluster(column=current, count=current);
	# make.shared(list=current, count=current, label=0.03);
	# classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	# get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);


	# set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	# set.current(shared=current, constaxonomy=current);
	# make.lefse(shared=current, constaxonomy=current);
	# make.biom(shared=current, constaxonomy=current);"


# # Renaming output files for use later

# # For OTU analysis
# cp "${OUTDIR}"/*.vsearch.fasta "${OTUDIR}"/final.fasta
# cp "${OUTDIR}"/*.vsearch.count_table "${OTUDIR}"/final.count_table

# # For Phylotype analysis
# cp "${OUTDIR}"/*.vsearch.fasta "${PHYLOTYPEDIR}"/final.fasta
# cp "${OUTDIR}"/*.vsearch.count_table "${PHYLOTYPEDIR}"/final.count_table

# # For ASV analysis
# cp "${OUTDIR}"/*.vsearch.fasta "${ASVDIR}"/final.fasta
# cp "${OUTDIR}"/*.vsearch.count_table "${ASVDIR}"/final.count_table

# # For Phylogeny analysis
# cp "${OUTDIR}"/*.vsearch.fasta "${PHYLOGENYDIR}"/final.fasta
# cp "${OUTDIR}"/*.vsearch.count_table "${PHYLOGENYDIR}"/final.count_table

# # For error rate analysis
# cp "${OUTDIR}"/*.vsearch.fasta "${ERRORDIR}"/errorinput.fasta
# cp "${OUTDIR}"/*.vsearch.count_table "${ERRORDIR}"/errorinput.count_table


# # For downstream OTU analysis
# cp "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
# cp "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
# cp "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
# cp "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
# cp "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
# cp "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
# cp "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
# cp "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.count_table
# cp "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
# cp "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


