from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule get_references:
	input:
		script="workflow/scripts/mothur_references.sh"
	output:
		silvaalign="data/mothur/references/silva.seed.align",
		silvav4="data/mothur/references/silva.v4.align",
		rdpfasta="data/mothur/references/trainset16_022016.pds.fasta",
		rdptax="data/mothur/references/trainset16_022016.pds.tax"
	shell:
		"bash {input.script}"


# Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		silvav4=rules.get_references.output.silvav4,
	output:
		mockv4="data/mothur/references/zymo.mock.16S.v4.fasta"
	shell:
		"bash {input.script}"
