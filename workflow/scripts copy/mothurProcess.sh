#! /bin/bash

# Set the variables to be used in this script
SAMPLEDIR="data/raw"
SILVAALIGN="data/references/silva.seed.align"
RDPFASTA="data/references/trainset16_022016.pds.fasta"
RDPTAX="data/references/trainset16_022016.pds.tax"

# Other variables
OUTDIR=data/processed/
ERRORDIR="${OUTDIR}"/error_analysis/

###################
# Run QC Analysis #
###################

# echo PROGRESS: Assembling, quality controlling, clustering, and classifying sequences.

echo PROGRESS: Here is what is going on:
echo 1. Creating sample files.
echo 2. Making contigs from fastq.gz files.
echo 3. Aligning reads to references.
echo 4. Removing any non-bacterial sequences.
echo 5. Calculating distance matrix.
echo 6. Creating OTU table.
echo 7. Assigning Taxonomy to OTUs.


# Making output dir
mkdir -p "${OUTDIR}" "${ERRORDIR}"


mothur "#set.logfile(name=seq_assembly.logfile);
    make.file(type=gz, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}", prefix=test);
	make.contigs(file=current);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);


    set.logfile(name=seq_align_preclustering.logfile)
    align.seqs(fasta=current, reference="${SILVAALIGN}");
    screen.seqs(fasta=current, count=current, maxhomop=8);
	summary.seqs(fasta=current, count=current)
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
	cluster(column=current, count=current, cutoff=0.03);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);
	
	set.logfile(name=lefse_n_biom.logfile);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"