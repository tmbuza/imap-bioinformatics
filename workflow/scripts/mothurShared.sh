#! /bin/bash
# mothurShared.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# # Set the variables to be used in this script
# SAMPLEDIR=${1:?ERROR: Need to define SAMPLEDIR.}
# SILVAV4=${2:?ERROR: Need to define SILVAV4.}
# RDPFASTA=${3:?ERROR: Need to define RDPFASTA.}
# RDPTAX=${4:?ERROR: Need to define RDPTAX.}

# Set the variables to be used in this script
SAMPLEDIR="data/raw"
SILVAV4="data/references/silva.v4.align"
RDPFASTA="data/references/trainset16_022016.pds.fasta"
RDPTAX="data/references/trainset16_022016.pds.tax"

# Other variables
OUTDIR="data/process"
ERRORDIR="data/process/error_analysis"

# Other variables




###################
# Run QC Analysis #
###################

echo PROGRESS: Assembling, quality controlling, clustering, and classifying sequences.

# Making output dir
mkdir -p "${OUTDIR}" "${ERRORDIR}" 

# Making contigs from fastq.gz files, aligning reads to references, removing any non-bacterial sequences, calculating distance matrix, making shared file, and classifying OTUs
# mothur "#make.file(type=fastq, prefix="test", inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
# 	make.contigs(file=current);
# 	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
# 	unique.seqs(fasta=current);
# 	unique.seqs(count=current);
# 	count.seqs(count=current, group=current);
# 	align.seqs(fasta=current, reference="${SILVAV4}");
# 	screen.seqs(fasta=current, count=current, start=1968, end=11550);
# 	filter.seqs(fasta=current, vertical=T, trump=.);
# 	unique.seqs(fasta=current, count=current);
# 	pre.cluster(fasta=current, count=current, diffs=2);
# 	chimera.vsearch(fasta=current, count=current, dereplicate=T);
# 	remove.seqs(fasta=current, accnos=current);
# 	classify.seqs(fasta=current, count=current, reference="${RDPFASTA}", taxonomy="${RDPTAX}", cutoff=80);
# 	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
# 	dist.seqs(fasta=current, cutoff=0.03);
# 	cluster(column=current, count=current);
# 	make.shared(list=current, count=current, label=0.03);
# 	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
# 	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance)"

mothur "#set.logfile(name=${OUTDIR}/logs/sample_files.logfile);
	set.dir(inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
	
	make.file(type=fastq, prefix=test, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
	
	set.logfile(name=${OUTDIR}/logs/seq_assembly.logfile);
	set.current(file=test.files);
	make.contigs(file=current);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);


	set.logfile(name=${OUTDIR}/logs/seq_align_precluster.logfile);
	set.current(fasta=current);
    align.seqs(fasta=current, reference="${SILVAV4}");
    screen.seqs(fasta=current, count=current, start=1968, end=11550, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=2);


	set.logfile(name=${OUTDIR}/logs/chimera_removal.logfile);
	set.current(fasta=current, count=current);
    chimera.vsearch(fasta=current, count=current, dereplicate=T);
    remove.seqs(fasta=current, accnos=current);


	set.logfile(name=${OUTDIR}/logs/remove_lineage.logfile);
	set.current(fasta=current, count=current);
   	classify.seqs(fasta=current, count=current, reference="${RDPFASTA}", taxonomy="${RDPTAX}", cutoff=80);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
	
	set.logfile(name=${OUTDIR}/logs/otu_clustering.logfile);
	set.current(fasta=current, count=current, taxonomy=current, list=current);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

	set.logfile(name=${OUTDIR}/logs/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"


# Renaming output files for use later
mv "${OUTDIR}"/*.precluster.pick.pick.fasta "${ERRORDIR}"/errorinput.fasta
mv "${OUTDIR}"/*.vsearch*.pick.count_table "${ERRORDIR}"/errorinput.count_table
mv "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.0.03.list
mv "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.0.03.steps
mv "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.0.03.sensspec
mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.0.03.shared
mv "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.0.03.cons.taxonomy
mv "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.0.03.cons.tax.summary
mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.0.03.rep.fasta
mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.0.03.rep.count_table
mv "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.0.03.lefse
mv "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.0.03.biom


###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/

# # # Deleting unneccessary files
# rm "${OUTDIR}"/*filter.unique.precluster*fasta
rm "${OUTDIR}"/*filter.unique.precluster*map
# rm "${OUTDIR}"/*filter.unique.precluster*count_table

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/

mkdir -p "${OUTDIR}"/logs/
mv "${OUTDIR}"/current_files.summary "${OUTDIR}"/logs/current_files.lolgfile
