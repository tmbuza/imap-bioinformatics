#! /bin/bash
# mothurShared.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################


# Set the variables to be used in this script
SAMPLEDIR="data/mothur/raw"
SILVAV4="data/mothur/references/silva.v4.align"
REFFASTA="data/mothur/references/trainset16_022016.pds.fasta"
REFTAXONOMY=$"data/mothur/references/trainset16_022016.pds.tax"


# Other variables
OUTDIR=data/mothur/process/
ERRORDIR="${OUTDIR}"/error_analysis/
LOGS="${OUTDIR}"/logs



###################
# Run QC Analysis #
###################

echo PROGRESS: Assembling, quality controlling, clustering, and classifying sequences.

# Making output dir
mkdir -p "${OUTDIR}" "${ERRORDIR}" "${LOGS}"

mothur "#make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
	make.contigs(file=test.files, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
	
	set.logfile(name="${LOGS}"/screen_unique.logfile);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);

	set.logfile(name=${LOGS}/align_n_filter.logfile);
	align.seqs(fasta=current, reference="${SILVAV4}");
	summary.seqs(fasta=current, count=current);	
	screen.seqs(fasta=current, count=current, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
	
	set.logfile(name=${LOGS}/denoise_n_classify.logfile);
	pre.cluster(fasta=current, count=current, diffs=2, inputdir=${OUTDIR}, outputdir=${OUTDIR});

	set.logfile(name=name=${LOGS}/chimera_removal.logfile);
	chimera.vsearch(fasta=current, count=current, dereplicate=t);
    remove.seqs(fasta=current, accnos=current);
	
	set.logfile(name=name=${LOGS}/classify_seq.logfile);
	classify.seqs(fasta=current, count=current, reference=${REFFASTA}, taxonomy=${REFTAXONOMY}, cutoff=97);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);

	set.logfile(name=${LOGS}/compute_seqdist003.logfile);
	dist.seqs(fasta=current, cutoff=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});

	set.logfile(name=${LOGS}/cluster_otu97.logfile);
	cluster(column=current, count=current);

	set.logfile(name=${LOGS}/classify_otu97.logfile);
	make.shared(list=current, count=current, label=0.03, inputdir=${OUTDIR}, outputdir=${OUTDIR});
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);

	set.logfile(name=${LOGS}/make_lefse.logfile);
	make.lefse(shared=current, constaxonomy=current);

	set.logfile(name=${LOGS}/make_biome.logfile);
	make.biom(shared=current, constaxonomy=current);

	set.logfile(name=${LOGS}/get_repfasta_repcount.logfile);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);
	
	"