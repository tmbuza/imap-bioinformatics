from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule get_bioinfo_resources:
    output:
        "data/reads/{accession}_1.fastq",
        "data/reads/{accession}_2.fastq",
    log:
        "logs/reads/{accession}.log"

    shell:
        """
        bash workflow/scripts/get_bioinfo_resources.sh
        """