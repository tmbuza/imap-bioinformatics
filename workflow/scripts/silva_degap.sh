#! /bin/bash
# silva_degap.sh


##################
# Set Script Env #
##################

OUTDIR=data/mothur/references # Directory for storing mothur reference files
FASTASILVA="data/mothur/references/silva.seed.align",
FASTAV4="data/mothur/references/silva.v4.align",

LOGS=data/mothur/logs

echo PROGRESS: Degapping silva alignment for classifying the sequences

mkdir -p "${OUTDIR}" "${LOGS}"

mothur "#set.logfile(name="${LOGS}"/degapping_silva.logfile);
    set.current(fasta="${FASTASILVA}")
    degap.seqs(fasta=current, inputdir="${OUTDIR}", outputdir="${OUTDIR}");
    
    set.current(fasta="${FASTAV4}")
    degap.seqs(fasta=current, inputdir="${OUTDIR}", outputdir="${OUTDIR}")"
