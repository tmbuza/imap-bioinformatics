rule make_contigs:
    input:
        script="workflow/scripts/make_contigs.sh",
        files=rules.make_files.output.files
    output:
        fasta="{outdir}/{dataset}.trim.contigs.good.unique.fasta",
        ctable="{outdir}/{dataset}.trim.contigs.good.count_table",
        uniqsmry="{outdir}/{dataset}.trim.contigs.good.unique.summary",
    threads: 2
    shell:
        "bash {input.script} {input.files}"