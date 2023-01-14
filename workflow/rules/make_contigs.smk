rule make_contigs:
    input:
        script="workflow/scripts/make_contigs.sh",
        files=rules.make_files.output.files
    output:
        fasta="{prefix}.fasta",
        counttable="{prefix}.count.table",
    shell:
        "bash {input.script} {input.files}"