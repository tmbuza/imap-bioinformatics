#!/bin/bash

INPUTDIR=data/mothur/raw
OUTDIR=results/qc

mkdir -p "${OUTDIR}" "${LOGS}"

echo PRGRESS: Computing read statistics using seqkit stat function.

seqkit stat ${INPUTDIR}/*.fastq.gz > ${OUTDIR}/seqkit1_stats.txt



# for i in `ls -1 ${INPUTDIR}/*_1.fastq.gz | sed 's/_1.fastq.gz//'`
#   do
#   bbduk.sh -Xmx4g in1=$i\_1.fastq.gz in2=$i\_2.fastq.gz out1=data/trimmed/$i\_1.fastq.gz out2=data/trimmed/$i\_2.fastq.gz qtrim=r trimq=25 overwrite=True
#   done

