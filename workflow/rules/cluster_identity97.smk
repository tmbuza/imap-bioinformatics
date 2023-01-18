rule cluster_identity97:
    input:
        script="workflow/scripts/cluster_identity97.sh",
        fasta=expand(rules.denoise_n_classify80.output.fasta, outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand(rules.denoise_n_classify80.output.ctable, outdir=config["outdir"], dataset=config["dataset"]),
        taxonomy=expand(rules.denoise_n_classify80.output.taxonomy, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        mcclist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list",
        steps="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.steps",
        sensspec="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.sensspec",
    threads: 2
    shell:
        "bash {input.script} {input.fasta}"
