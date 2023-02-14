from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule denoise_n_classify80:
    input:
        script="workflow/scripts/denoise_n_classify80.sh",
        fasta=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.count_table", outdir=config["outdir"], dataset=config["dataset"]),
        rdpfasta=rules.get_references.output.rdpfasta,
        rdptax=rules.get_references.output.rdptax,
    output:
        fasta="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta",
        ctable="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table",
        taxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.taxonomy",
        accnos="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.accnos",
    threads: 2
    shell:
        "bash {input.script} {input.fasta} {input.ctable}"