rule compute_seqdist003:
    input:
        script="workflow/scripts/compute_seqdist003.sh",
        fasta=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta", outdir=config["outdir"], dataset = config["dataset"]),
    output:
        dist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.dist"
    threads: 2
    shell:
        "bash {input.script} {input.fasta}"


rule cluster_otu97:
    input:
        script="workflow/scripts/cluster_otu97.sh",
        dist=expand(rules.compute_seqdist003.output.dist, outdir=config["outdir"], dataset = config["dataset"]),
        ctable=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table", outdir=config["outdir"], dataset = config["dataset"]),
    output:
        mcclist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.list",
        # steps="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.steps",
        # sensspec="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.sensspec",
    threads: 2
    shell:
        "bash {input.script}"


rule classify_otu97:
    input:
        script="workflow/scripts/classify_otu97.sh",
        mcclist=expand(rules.cluster_otu97.output.mcclist, outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand(rules.denoise_n_classify80.output.ctable, outdir=config["outdir"], dataset=config["dataset"]),
        taxonomy=expand(rules.denoise_n_classify80.output.taxonomy, outdir=config["outdir"], dataset=config["dataset"]),
        fasta=expand(rules.denoise_n_classify80.output.fasta, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        shared="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.shared",
        # constaxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.cons.taxonomy",
        # constaxsummary="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.cons.tax.summary",
        # lefse="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.lefse",
        biom="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.biom",
        # repfasta="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.rep.fasta",
        # reptable="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.0.03.rep.count_table",
    threads: 2
    shell:
        "bash {input.script}"
