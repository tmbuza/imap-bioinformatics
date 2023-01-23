from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule make_contigs:
    input:
        script="workflow/scripts/make_contigs.sh",
        files="data/mothur/process/test.files",
        # files=rules.make_files.output.files
    output:
        fasta="{outdir}/{dataset}.trim.contigs.good.unique.fasta",
        ctable="{outdir}/{dataset}.trim.contigs.good.count_table",
        uniqsmry="{outdir}/{dataset}.trim.contigs.good.unique.summary",
    threads: 2
    shell:
        "bash {input.script} {input.files}"