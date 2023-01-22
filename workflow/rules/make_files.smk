from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule make_files:
    input:
        script="workflow/scripts/make_files.sh",
    output:
        files="{outdir}/{dataset}.files",
    shell:
        "bash {input.script}"