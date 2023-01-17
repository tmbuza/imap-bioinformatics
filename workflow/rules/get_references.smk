# Snakefile
# Snakemake file for 16S pipeline

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule all:
    input:
        expand("{dbdir}/silva.seed.align", dbdir=config["dbdir"]),

        expand("{dbdir}/trainset16_022016.pds.fasta", dbdir=config["dbdir"]),
        expand("{dbdir}/trainset16_022016.pds.tax", dbdir=config["dbdir"]),

        expand("{dbdir}/zymo.mock.16S.fasta", dbdir=config["dbdir"]),

# ############
# # RULES
# ############		
# # SILVA database for use as reference alignment.
# rule get_silva_alignements:
# 	input:
# 		script="workflow/scripts/mothur_silva.sh"
# 	output:
# 		silvaSeed="data/mothur/references/silva.seed.align",
# 		silvaV4="data/mothur/references/silva.v4.align",
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"


# # RDP database for use as reference classifier.
# rule get_rdp_classifier:
# 	input:
# 		script="workflow/scripts/mothur_rdp.sh"
# 	output:
# 		rdpFasta="data/mothur/references/trainset16_022016.pds.fasta",
# 		rdpTax="data/mothur/references/trainset16_022016.pds.tax"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"


# # Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
# rule get_zymo_mock:
# 	input:
# 		script="workflow/scripts/mothur_zymo_mock.sh",
# 		silvaV4=rules.get_silva_alignements.output.silvaV4
# 	output:
# 		mockV4="data/mothur/references/zymo.mock.16S.v4.fasta"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"

# SILVA database for use as reference alignment.
rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		align="{dbdir}/silva.seed.align",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# RDP database for use as reference classifier.
rule get_rdp_classifier:
	input:
		script="workflow/scripts/mothur_rdp.sh"
	output:
		rdpfasta="{dbdir}/trainset16_022016.pds.fasta",
		rdptax="{dbdir}/trainset16_022016.pds.tax"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		refs=rules.get_silva_alignements.output.align
	output:
		mockrefs="{dbdir}/zymo.mock.16S.fasta"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"

