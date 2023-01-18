rule make_files:
    input:
        script="workflow/scripts/make_files.sh",
    output:
        files="{outdir}/{dataset}.files",
    shell:
        "bash {input.script}"