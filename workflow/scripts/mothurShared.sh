#! /bin/bash
# mothurShared.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
SAMPLEDIR="data/raw"
SILVAV4="data/references/silva.v4.align"
RDPFASTA="data/references/trainset16_022016.pds.fasta"
RDPTAX="data/references/trainset16_022016.pds.tax"

# Other variables
OUTDIR=data/process/
ERRORDIR="${OUTDIR}"/error_analysis/



###################
# Run QC Analysis #
###################

echo PROGRESS: Assembling, quality controlling, clustering, and classifying sequences.

# Making output dir
mkdir -p "${OUTDIR}" "${ERRORDIR}"
# mothur "#make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
# 	make.contigs(file=current);
# 	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
# 	unique.seqs(fasta=current);
# 	count.seqs(name=current, group=current);
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

# Making contigs from fastq.gz files, aligning reads to references, removing any non-bacterial sequences, calculating distance matrix, making shared file, and classifying OTUs
mothur "#
	set.logfile(name=sample_files.logfile);
	make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}", prefix=test);
	
	set.logfile(name=seq_assembly.logfile);
	make.contigs(file=current);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);


	set.logfile(name=seq_align_precluster.logfile);
    align.seqs(fasta=current, reference="${SILVAV4}");
    screen.seqs(fasta=current, count=current, start=1968, end=11550, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=2);


	set.logfile(name=chimera_removal.logfile);
    chimera.vsearch(fasta=current, count=current, dereplicate=T);
    remove.seqs(fasta=current, accnos=current);


	set.logfile(name=remove_lineage.logfile);
   	classify.seqs(fasta=current, count=current, reference="${RDPFASTA}", taxonomy="${RDPTAX}", cutoff=80);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
	
	set.logfile(name=otu_clustering.logfile);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);


	set.logfile(name=lefse_n_biom.logfile);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"


# Renaming output files for use later
mv "${OUTDIR}"/*.precluster*.pick.pick.fasta "${ERRORDIR}"/errorinput.fasta
mv "${OUTDIR}"/*.vsearch*.pick.count_table "${ERRORDIR}"/errorinput.count_table
mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
mv "${OUTDIR}"/*.cons.taxonomy "${OUTDIR}"/final.taxonomy
mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.seqs
mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table


###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/


# Deleting unneccessary files
rm "${OUTDIR}"/*filter.unique.precluster*fasta
rm "${OUTDIR}"/*filter.unique.precluster*map
rm "${OUTDIR}"/*filter.unique.precluster*count_table

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/

# Moving all logfiles files to the logs dir
mkdir -p "${OUTDIR}"/logs/
mv "${OUTDIR}"/*.logfile "${OUTDIR}"/logs/
