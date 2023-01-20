rule count_groups:
    input:
        script="workflow/scripts/count_groups.sh",
        shared=expand("{finaldir}/{group}.final.shared", finaldir=config["finaldir"], group=['sample','mock']),
    output:
        samplecount="{finaldir}/{group}.final.count.summary"
    shell:
        "bash {input.script} {input.shared}"      
