from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule samples_units_files:
    input:
        "data/metadata/metadata.csv"
    output:
        "config/samples.tsv",
        "config/units.tsv",
    script:
        """
        scripts/make_samples_units.py
        """
