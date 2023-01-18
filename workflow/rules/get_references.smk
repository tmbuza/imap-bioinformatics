rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		silvaalign="{refsdir}/{silva}.seed.align",
		silvav4="{refsdir}/{silva}.v4.align"
	shell:
		"bash {input.script}"


rule silva_classifier:
	input:
		script="workflow/scripts/mothur_degap_align.sh",
		silvaalign=expand(rules.get_silva_alignements.output.silvaalign, refsdir=config["refsdir"], silva="silva"),
		silvav4=expand(rules.get_silva_alignements.output.silvav4, refsdir=config["refsdir"], silva="silva"),
	output:
		seedfasta="{refsdir}/{silva}.seed.ng.fasta",
		v4fasta="{refsdir}/{silva}.v4.ng.fasta"
	shell:
		"bash {input.script}"


rule get_rdp_classifier:
	input:
		script="workflow/scripts/mothur_rdp.sh"
	output:
		rdpfasta="{refsdir}/{rdp}.pds.fasta",
		rdptax="{refsdir}/{rdp}.pds.tax",
	shell:
		"bash {input.script}"



rule get_zymo_mock:
	input:
		script="workflow/scripts/mothur_zymo_mock.sh",
		silvav4=expand(rules.get_silva_alignements.output.silvav4, refsdir=config["refsdir"], silva="silva"),
	output:
		mockrefs="{refsdir}/{zymo}.mock.16S.v4.fasta"
	shell:
		"bash {input.script}"
