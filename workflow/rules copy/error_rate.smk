from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"



rule error_rate:
	input:
		script="workflow/scripts/error_rate.sh",
		errorfasta=expand("{erroranalysis}/errorinput.fasta", erroranalysis=config["erroranalysis"]),
		errorcount=expand("{erroranalysis}/errorinput.count_table", erroranalysis=config["erroranalysis"]),
		mockv4=rules.get_zymo_mock.output.mockv4,
	output:
		summary="{erroranalysis}/errorinput.pick.error.summary"
	params:
		mockGroups='-'.join(config["mothurMock"]) # Concatenates all mock group names with hyphens
	shell:
		"bash {input.script} {input.errorfasta} {input.errorcount} {input.mockv4} {params.mockGroups}"
