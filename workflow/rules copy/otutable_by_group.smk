from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule split_by_group:
    input:
        script="workflow/scripts/otutable_by_group.sh",
        shared=expand("{finalotus}/final.shared", finalotus=config["finalotus"]),
    output:
        shared="{finalotus}/{group}.final.shared",
    params:
        mockGroups='-'.join(config["mothurMock"]),
        controlGroups='-'.join(config["mothurControl"])
    shell:
        "bash {input.script} {params.mockGroups} {params.controlGroups}"
