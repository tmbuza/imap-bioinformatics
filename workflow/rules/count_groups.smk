from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule count_groups:
    input:
        script="workflow/scripts/count_groups.sh",
        shared=expand("{finalotus}/{group}.final.shared", finalotus=config["finalotus"], group=config["mothurGroups"]),
    output:
        samplecount="{finalotus}/{group}.final.count.summary"
    shell:
        "bash {input.script} {input.shared}"      
