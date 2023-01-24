from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule seqkit_1:
    input:
        script="workflow/scripts/seqkit1.sh",
        # rawreads="data/mothur/raw/{samples}"
    output:
        seqkit1="results/qc/seqkit1_stats.txt",
    log:
        "logs/seqkit1_stats.log",
    # conda:
    #     "envs/readqc.yaml"
    threads: 1
    shell:
        "bash {input.script}"


rule fastqc_1:
    input:
        script="workflow/scripts/fastqc1.sh",
        # rawreads="data/mothur/raw/{samples}"
    output:
        fastqc1="results/qc/fastqc1/F3D0_S188_L001_R1_001_fastqc.html",
    log:
        "logs/fastqc1.log",
    # conda:
    #     "envs/readqc.yaml"
    threads: 1
    shell:
        "bash {input.script}"
        "bash {input.script}"


rule multiqc_1:
    input:
        script="workflow/scripts/multiqc1.sh",
        # rawreads="data/mothur/raw/{samples}"
    output:
        fastqc1="results/qc/multiqc1/multiqc.html",
    log:
        "logs/multiqc.log",
    # conda:
    #     "envs/readqc.yaml"
    threads: 1
    shell:
        "bash {input.script}"