rule classify_asv:
    input:
        script="workflow/scripts/classify_asv.sh",
        ctable=expand(rules.denoise_n_classify80.output.ctable, outdir=config["outdir"], dataset=config["dataset"]),
        taxonomy=expand(rules.denoise_n_classify80.output.taxonomy, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        # asvlist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.list",
        shared="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.shared",
        # constaxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.ASV.cons.taxonomy",
        # constaxsummary="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.ASV.cons.tax.summary",
        # lefse="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.ASV.lefse",
        # biome="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.asv.ASV.biom",
    threads: 2
    shell:
        "bash {input.script}"
