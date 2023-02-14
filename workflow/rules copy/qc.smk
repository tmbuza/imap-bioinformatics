from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/reads/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

sraSamples = list(set(glob_wildcards(os.path.join('data/mothur/reads/', '{sample}_{sraNum, [12]}.fastq.gz')).sample))


rule qc_rawreads:
    input:
        script="workflow/scripts/qc1.sh",
        rawreads=expand('data/mothur/reads/{mothurSamples}_{readNum}_001.fastq', mothurSamples = mothurSamples, readNum = config["readNum"]),
    output:
        seqkit1="results/qc/seqkit1/seqkit_stats.txt",
        multiqc1="results/qc/multiqc1/multiqc_report.html"
    threads: 1
    shell:
      "bash {input.script} {input.rawreads}"
