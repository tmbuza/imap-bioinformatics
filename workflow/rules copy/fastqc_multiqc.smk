from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule fastqc:
    input:
        script="workflow/scripts/fastqc.sh",
        rawreads=expand('data/mothur/reads/{mothurSamples}_{readNum}_001.fastq', mothurSamples = mothurSamples, readNum = config["readNum"]),
    output:
        html="results/qc/fastqc1/{mothurSamples}_{readNum}_fastqc.html", 
        zipped="results/qc/fastqc1/{mothurSamples}_{readNum}_fastqc.zip", 
    threads: 1
    shell:
        "bash {input.script} {input.rawreads} {input.threads}"



rule multiqc:
    input:
        script="workflow/scripts/multiqc.sh",
    output:
        "results/qc/multiqc1/multiqc_report.html",
    log:
        "logs/multiqc.log",
    threads: 1
    shell:
        "bash {input.script}"

