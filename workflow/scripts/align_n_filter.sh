# Set the variables to be used in this script
SAMPLEDIR="data/raw"
OUTDIR="data/process/"
FASTA2ALIGN="data/process/test.trim.contigs.good.fasta"
SILVAALIGN="data/references/silva.seed.align"
# RDPFASTA="data/references/trainset16_022016.pds.fasta"
# RDPTAX="data/references/trainset16_022016.pds.tax"


# # Making contigs from fastq.gz files, aligning reads to references, removing any non-bacterial sequences, calculating distance matrix, making shared file, and classifying OTUs
#  mothur "#set.logfile(name=make_contigs.logfile);
#       make.contigs(file=data/process/test.files, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
#       screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
#       unique.seqs(count=current);
#       summary.seqs(fasta=current, count=current);" 


# Aligning reads to references, removing any non-bacterial sequences, calculating distance matrix, making shared file, and classifying OTUs
mothur "#set.logfile(name=align_n_clean.logfile);
	align.seqs(fasta="${FASTA2ALIGN}", reference="${SILVAALIGN}, inputdir="${OUTDIR}", outputdir="${OUTDIR});
    screen.seqs(fasta=current, count=current, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=2);"

# Calculating distance matrix, making shared file, and classifying OTUs
# 	dist.seqs(fasta=current, cutoff=0.03);
# 	cluster(column=current, count=current);
# 	make.shared(list=current, count=current, label=0.03);
# 	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
# 	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance)"

