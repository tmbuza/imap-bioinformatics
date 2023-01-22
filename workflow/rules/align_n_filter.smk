from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule align_n_filter:
    input:
        script="workflow/scripts/align_n_filter.sh",
        fasta=rules.make_contigs.output.fasta,
        ctable=rules.make_contigs.output.ctable,
        silvav4=expand(rules.get_silva_alignements.output.silvav4, refsdir=config["refsdir"], silva="silva"),
    output:
        alignfasta="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.fasta",
        smry="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.count_table",
    threads: 2
    shell:
        "bash {input.script} {input.fasta}"
