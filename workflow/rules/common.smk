from snakemake.utils import min_version

min_version("5.18.0")

report: "../report/workflow.rst"

container: "continuumio/miniconda3:4.8.2"

configfile: "config/config.yml"

OUTDIR="data/reads"  

SAMPLES = list(set(glob_wildcards(os.path.join('data/reads', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

if not os.path.exists(OUTDIR): os.makedirs(OUTDIR)


