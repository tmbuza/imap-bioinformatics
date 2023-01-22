##################################################################
#
# Part 3: Diversity Metrics 
#
##################################################################

rule rarefy_reads:
	input:
		script="workflow/scripts/rarefy_reads.sh",
		shared="{finalotus}/sample.final.shared"
	output:
		rarefaction="{finalotus}/sample.final.groups.rarefaction"
	shell:
		"bash {input.script} {input.shared}"


# Calculating alpha diversity metrics (within sample diversity).
rule alpha_diversity:
	input:
		script="workflow/scripts/alpha_diversity.sh",
		shared="{finalotus}/sample.final.shared",
		samplecount="{finalotus}/sample.final.count.summary"
	output:
		alpha="{finalotus}/sample.final.groups.ave-std.summary"
	params:
		subthresh=config["subthresh"],
		alpha='-'.join(config["mothurAlpha"]) # Concatenates all alpha metric names with hyphens
	shell:
		"bash {input.script} {input.shared} {input.count} {params.subthresh} {params.alpha}"


# Calculating beta diversity metrics (between sample diversity).
rule beta_diversity:
	input:
		script="workflow/scripts/beta_diversity.sh",
		shared="{finalotus}/sample.final.shared",
		samplecount="{finalotus}/sample.final.count.summary"
	output:
		dist=expand("{finalotus}/sample.final.{beta}.0.03.lt.ave.dist",
			finalotus=config["finalotus"],
            beta=config["mothurBeta"])
	params:
		subthresh=config["subthresh"],
		beta='-'.join(config["mothurBeta"]) # Concatenates all beta metric names with hyphens
	shell:
		"bash {input.script} {input.shared} {input.count} {params.subthresh} {params.beta}"


