rule subsample_otutable:
	input:
		script="workflow/scripts/subsample_otutable.sh",
		shared=expand("{finaldir}/{group}.final.shared", finaldir=config["finaldir"], group=['sample','mock']),
		readcount=expand("{finaldir}/{group}.final.count.summary", finaldir=config["finaldir"], group=['sample','mock']),
	output:
		subsample="{finadir}/{group}.final.0.03.subsample.shared"
	shell:
		"bash {input.script} {input.shared} {input.count}"

# # Counting number of reads in each of the new shared files.
# rule count16SShared:
# 	input:
# 		script="workflow/scripts/count_groups.sh",
# 		shared=expand("{finadir}/{group}.final.shared", finaldir=config["finaldir"], group = ['sample','mock']),
# 	output:
# 		grpcount=expand("{finadir}/{group}.final.count.summary", finaldir=config["finaldir"], group = ['sample','mock']),
# 	shell:
# 		"bash {input.script} {input.shared}"


# # Uses read counts to subsample shared files to the largest number of reads above a given read
# # threshold denoted as 'subthresh'.
# rule subsample16SShared:
# 	input:
# 		script="workflow/scripts/subsample_otutable.sh",
# 		shared=expand("{finadir}/{group}.final.shared", finaldir=config["finaldir"], group = ['sample','mock']),
# 		grpcount=expand("{finadir}/{group}.final.count.summary", finaldir=config["finaldir"], group = ['sample','mock']),
# 	output:
# 		subsampleShared="{finadir}/{group}.final.0.03.subsample.shared"
# 	params:
# 		subthresh=config["subthresh"]
# 	shell:
# 		"bash {input.script} {input.shared} {input.count} {params.subthresh}"