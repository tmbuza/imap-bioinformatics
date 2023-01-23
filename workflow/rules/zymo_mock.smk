from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		silvav4="data/mothur/references/silva.v4.align",
	output:
		mockv4="data/mothur/references/zymo.mock.16S.v4.fasta"
	shell:
		"bash {input.script}"
