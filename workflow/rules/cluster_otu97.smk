rule cluster_otu97:
    input:
        script="workflow/scripts/cluster_otu97.sh",
        dist=expand(rules.compute_seqdist003.output.dist, outdir=config["outdir"], dataset = config["dataset"]),
        ctable=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table", outdir=config["outdir"], dataset = config["dataset"]),
    output:
        mcclist=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.list", outdir=config["outdir"], dataset=config["dataset"]),
        steps=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.steps", outdir=config["outdir"], dataset=config["dataset"]),
        sensspec=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.sensspec", outdir=config["outdir"], dataset=config["dataset"]),
    threads: 2
    shell:
        "bash {input.script}"