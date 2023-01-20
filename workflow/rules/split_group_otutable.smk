rule split_group_otutable:
    input:
        script="workflow/scripts/split_group_otutable.sh",
        shared=expand("{finaldir}/final.shared", finaldir=config["finaldir"]),
    output:
        shared=expand("{finaldir}/{group}.final.shared", finaldir=config["finaldir"], group = "mothurGroups")
    params:
        mockGroups='-'.join(config["mothurMock"]),
        controlGroups='-'.join(config["mothurControl"])
    shell:
        "bash {input.script} {params.mockGroups} {params.controlGroups}"
