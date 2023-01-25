#!/bin/bash

INPUTDIR=data/mothur/reads
OUTDIR=data/mothur/trimmed

mkdir -p "${OUTDIR}"

for i in `ls -1 ${INPUTDIR}/*_1.fastq.gz | sed 's/_1.fastq.gz//'`
  do
  bbduk.sh -Xmx4g in1=$i\_1.fastq.gz in2=$i\_2.fastq.gz out1=${OUTDIR}/$i\_1.fastq.gz out2=${OUTDIR}/$i\_2.fastq.gz qtrim=r trimq=25 overwrite=True
  done

  