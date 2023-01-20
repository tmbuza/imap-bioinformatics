rule compute_seqdist003:
    input:
        script="workflow/scripts/compute_seqdist003.sh",
        fasta=expand("{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta", outdir=config["outdir"], dataset = config["dataset"]),
    output:
        dist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.dist"
    threads: 2
    shell:
        "bash {input.script} {input.fasta}"


