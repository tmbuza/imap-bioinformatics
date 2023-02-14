from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule subsample_otutable:
	input:
		script="workflow/scripts/subsample_otutable.sh",
		shared=expand("{finalotus}/{group}.final.shared", finalotus=config["finalotus"], group=config["mothurGroups"]),
		readcount=expand("{finalotus}/{group}.final.count.summary", finalotus=config["finalotus"], group=config["mothurGroups"]),
	output:
		subsample="{finalotus}/{group}.final.0.03.subsample.shared"
	params:
		subthresh=config["subthresh"]
	shell:
		"bash {input.script} {input.shared} {input.readcount} {params.subthresh}"