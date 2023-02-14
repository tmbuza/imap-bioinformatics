#! /bin/bash
# make_contigs.sh

FASTA="data/mothur/test.trim.contigs.fasta"
COUNT="data/mothur/test.trim.contigs.fasta"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"
FILES="test.files"

# Other variables




###################
# Run QC Analysis #
###################

echo PROGRESS: Assembling and Screening unique representative sequences.

# Output dirs
mkdir -p "${OUTDIR}" "${LOGS}"

mothur "#set.logfile(name=${LOGS}/screen_unique.logfile);
	set.current(fasta=${FASTA}, count=${COUNT});
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current, inputdir=${SAMPLEDIR}, outputdir=${OUTDIR});"