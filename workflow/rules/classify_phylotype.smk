rule classify_phylotype:
    input: 
        script="workflow/scripts/classify_phylotype.sh",
        taxonomy=expand(rules.denoise_n_classify80.output.taxonomy, outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand(rules.denoise_n_classify80.output.ctable, outdir=config["outdir"], dataset=config["dataset"]),
    output: 
        txlist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.list",
        # rabund="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.rabund",
        # sabund="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.sabund",
        shared="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.shared",
        # constaxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.1.cons.taxonomy",
        # constaxsummary="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.1.cons.tax.summary",
        # lefse="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.1.lefse",
        biom="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pds.wang.pick.tx.1.biom",
    threads: 2
    shell:
        "bash {input.script} {threads}"
