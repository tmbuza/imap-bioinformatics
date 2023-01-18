rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		align="{dbdir}/silva.seed.align",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"