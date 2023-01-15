rule all:
	input:
		"data/mothur/references/silva.seed.align",
		"data/mothur/references/silva.v4.align",
		"data/mothur/references/trainset16_022016.pds.fasta",
		"data/mothur/references/trainset16_022016.pds.tax",
		"data/mothur/references/zymo.mock.16S.v4.fasta"

############
# RULES
############		
# SILVA database for use as reference alignment.
rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		silvaSeed="data/mothur/references/silva.seed.align",
		silvaV4="data/mothur/references/silva.v4.align",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# RDP database for use as reference classifier.
rule get_rdp_classifier:
	input:
		script="workflow/scripts/mothur_rdp.sh"
	output:
		rdpFasta="data/mothur/references/trainset16_022016.pds.fasta",
		rdpTax="data/mothur/references/trainset16_022016.pds.tax"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		silvaV4=rules.get_silva_alignements.output.silvaV4
	output:
		mockV4="data/mothur/references/zymo.mock.16S.v4.fasta"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"

