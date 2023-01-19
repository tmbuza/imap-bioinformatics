# Splitting shared by group
rule split_group_otutable:
    input:
        script="workflow/scripts/split_group_otutable.sh",
        shared=expand("{outdir}/final.shared", outdir=config["outdir"]),
    output:
        shared=expand("{outdir}/{group}.final.shared", outdir=config["outdir"], group = config["mothurGroups"])
    params:
        mockGroups='-'.join(config["mothurMock"]),
        controlGroups='-'.join(config["mothurControl"])
    shell:
        "bash {input.script} {params.mockGroups} {params.controlGroups}"
