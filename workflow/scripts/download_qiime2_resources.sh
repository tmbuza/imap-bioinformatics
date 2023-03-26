mkdir -p qiime2_tutorial
mkdir -p qiime2_tutorial/metadata
mkdir -p qiime2_tutorial/reads
mkdir -p qiime2_tutorial/references

wget \
  -OP "qiime2_tutorial/metadata/sample-metadata.tsv" \
  "https://data.qiime2.org/2023.2/tutorials/atacama-soils/sample_metadata.tsv"

wget \
  -OP "qiime2_tutorial/reads/forward.fastq.gz" \
  "https://data.qiime2.org/2023.2/tutorials/atacama-soils/10p/forward.fastq.gz"

wget \
  -OP "qiime2_tutorial/reads/reverse.fastq.gz" \
  "https://data.qiime2.org/2023.2/tutorials/atacama-soils/10p/reverse.fastq.gz"

wget \
  -OP "qiime2_tutorial/reads/barcodes.fastq.gz" \
  "https://data.qiime2.org/2023.2/tutorials/atacama-soils/10p/barcodes.fastq.gz"