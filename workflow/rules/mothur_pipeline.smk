from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Function for aggregating list of raw sequencing files.
mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

sraSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{sraNum, [12]}.fastq.gz')).sample))


rule all:
    input:
        expand("{outdir}/{dataset}.files", outdir=config["outdir"], dataset=config["dataset"]),

        # make_contigs.smk
        expand("{outdir}/{dataset}.trim.contigs.good.unique.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.count_table", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.unique.summary", outdir=config["outdir"], dataset=config["dataset"]),

        # align_n_filter.smk
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.count_table", outdir=config["outdir"], dataset=config["dataset"]),

        # denoise_n_classify80.smk
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy", outdir=config["outdir"], dataset=config["dataset"]),
        expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.accnos", outdir=config["outdir"], dataset=config["dataset"]),

        # expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.list", outdir=config["outdir"], dataset=config["dataset"]),

include: "get_references.smk"
include: "make_files.smk"
include: "make_contigs.smk"
include: "align_n_filter.smk"
include: "denoise_n_classify80.smk"
include: "compute_dist97.smk"