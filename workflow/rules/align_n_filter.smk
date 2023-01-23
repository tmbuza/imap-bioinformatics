from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule align_n_filter:
    input:
        script="workflow/scripts/align_n_filter.sh",
        fasta=expand("{outdir}/{dataset}.trim.contigs.good.unique.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand("{outdir}/{dataset}.trim.contigs.good.count_table", outdir=config["outdir"], dataset=config["dataset"]),
        silvav4=rules.get_references.output.silvav4,
    output:
        alignfasta="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.fasta",
        ctable="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.count_table",
    threads: 2
    shell:
        "bash {input.script} {input.fasta}"
