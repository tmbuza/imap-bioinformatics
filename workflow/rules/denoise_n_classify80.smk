rule denoise_n_classify80:
    input:
        script="workflow/scripts/denoise_n_classify80.sh",
        fasta=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.fasta", outdir=config["outdir"], dataset=config["dataset"]),
        ctable=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.count_table", outdir=config["outdir"], dataset=config["dataset"]),
        rdpfasta=expand(rules.get_rdp_classifier.output.rdpfasta, refsdir=config["refsdir"], rdp="trainset16_022016"),
        rdptax=expand(rules.get_rdp_classifier.output.rdptax, refsdir=config["refsdir"], rdp="trainset16_022016"),
    output:
        fasta="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta",
        ctable="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table",
        taxonomy="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy",
        accnos="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.accnos",
    threads: 2
    shell:
        "bash {input.script} {input.fasta} {input.ctable}"
