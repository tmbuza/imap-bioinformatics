rule get_otutable:
    input:
        script="workflow/scripts/get_otutable.sh",
        mcclist=expand(rules.cluster_identity97.output.mcclist, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        shared="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.shared",
        constaxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.0.03.cons.taxonomy",
        constaxsmry="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.0.03.cons.tax.summary",
        ctable="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.0.03.rep.count_table",
        lefse="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.0.03.lefse",
        biom="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.opti_mcc.0.03.biom",
    threads: 2
    shell:
        "bash {input.script}"
