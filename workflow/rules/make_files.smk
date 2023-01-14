rule make_files:
    input:
        script="workflow/scripts/make_files.sh",
    output:
        files="{dataset}.files",
    shell:
        "bash {input.script}"