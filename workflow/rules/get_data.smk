from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		align="{dbdir}/silva.seed.align",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"