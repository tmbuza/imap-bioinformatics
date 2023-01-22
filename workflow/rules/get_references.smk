from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		silvaalign="data/mothur/references/silva.seed.align",
		silvav4="data/mothur/references/silva.v4.align"
	shell:
		"bash {input.script}"


rule silva_classifier:
	input:
		script="workflow/scripts/silva_classifier.sh",
		silvaalign=expand(rules.get_silva_alignements.output.silvaalign, refsdir=config["refsdir"]),
		silvav4=expand(rules.get_silva_alignements.output.silvav4, refsdir=config["refsdir"]),
	output:
		seedfasta="data/mothur/references/silva.seed.ng.fasta",
		v4fasta="data/mothur/references/silva.v4.ng.fasta"
	shell:
		"bash {input.script}"


rule get_rdp_classifier:
	input:
		script="workflow/scripts/mothur_rdp.sh"
	output:
		rdpfasta="data/mothur/references/{rdp}.pds.fasta",
		rdptax="data/mothur/references/{rdp}.pds.tax",
	shell:
		"bash {input.script}"



rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		silvav4=expand(rules.get_silva_alignements.output.silvav4, refsdir=config["refsdir"], silva="silva"),
	output:
		mockrefs="data/mothur/references/{zymo}.mock.16S.v4.fasta"
	shell:
		"bash {input.script}"
