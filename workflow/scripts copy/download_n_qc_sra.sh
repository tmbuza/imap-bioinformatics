#!/usr/bin/env bash

# Create a project directory

OUTDIR="data/mothur/srareads"
# ADAPTERS="data/mothur/adapters"

mkdir -p "${OUTDIR}"

# Downloading read data
wget -P "${OUTDIR}" https://zenodo.org/record/5562251/files/SRR2584866_1.fq.gz
wget -P "${OUTDIR}" https://zenodo.org/record/5562251/files/SRR2584866_2.fq.gz
wget -P "${OUTDIR}" https://zenodo.org/record/5562251/files/SRR2589044_1.fq.gz
wget -P "${OUTDIR}" https://zenodo.org/record/5562251/files/SRR2589044_2.fq.gz

# # Downloading adapter
# wget -P "${ADAPTERS}" https://raw.githubusercontent.com/timflutre/trimmomatic/master/adapters/NexteraPE-PE.fa


# # Generate FastQC Report
# mkdir -p "${OUTDIR}"/fastqc
# fastqc "${OUTDIR}"/*.fq.gz --outdir fastqc/



# # Run Trimmomatic to trim the bad reads out.

# trimmomatic PE "${OUTDIR}"/SRR2589044_1.fq.gz "${OUTDIR}"/SRR2589044_2.fq.gz \
#                "${OUTDIR}"/SRR2589044_1.trim.fq "${OUTDIR}"/SRR2589044_1un.trim.fq \
#                "${OUTDIR}"/SRR2589044_2.trim.fq "${OUTDIR}"/SRR2589044_2un.trim.fq \
#                SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:"${ADAPTERS"/NexteraPE-PE.fa:2:40:15

# trimmomatic PE "${OUTDIR}"/SRR2584866_1.fq.gz "${OUTDIR}"/SRR2584866_2.fq.gz \
#                "${OUTDIR}"/SRR2584866_1.trim.fq "${OUTDIR}"/SRR2584866_1un.trim.fq \
#                "${OUTDIR}"/SRR2584866_2.trim.fq "${OUTDIR}"/SRR2584866_2un.trim.fq \
#                SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:"${ADAPTERS"/NexteraPE-PE.fa:2:40:15

# # Generate Updated FastQC Report
# mkdir -p "${OUTDIR}"/trimmed
# fastqc "${OUTDIR}"/*.trim.fq --outdir "${OUTDIR}"/trimmed
