# imap2_mothur_bioinformatics.smk

# Snakemake file for running mothur 16S pipeline

from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Function for aggregating list of raw sequencing files.
mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

# Master rule for controlling workflow.
rule all:
    input:
        "data/mothur/process/test.files",
        "data/mothur/process/falinal.taxonomy",    
        "data/mothur/process/fin.shared",
        "data/mothur/process/error_analysis/errorinput.fasta",
        "data/mothur/process/error_analysis/errorinput.count_table",
        "data/mothur/process/test.files",
        "data/mothur/reads/{mothurSamples}_{readNum}_001.fastq.gz"

# Get mothur-based reference
rule get_mothur_references:
	input:
		script="code/bash/mothurReferences.sh"
	output:
		silvaV4="data/mothur/references/silva.v4.align",
		rdpFasta="data/mothur/references/trainset16_022016.pds.fasta",
		rdpTax="data/mothur/references/trainset16_022016.pds.tax"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# Get Zymo mock reference.
rule get_zymo_mock:
	input:
		script="code/bash/mothurMock.sh",
		silvaV4=rules.get_mothur_references.output.silvaV4
	output:
		mockV4="data/mothur/references/zymo.mock.16S.v4.fasta"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"

# Get rawread data.
rule get_read_data:
	input:
		script="code/bash/getReads.sh",
	output:
		reads="data/mothur/reads/{mothurSamples}_{readNum}_001.fastq.gz"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"


# Making mothur-based sample mapping file.
rule make_mapping_file:
	input:
		script="code/bash/makeFile.sh",
	output:
		samplemapping="data/mothur/process/test.files",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} data/mothur/reads/ {input.reads}"


# Assemble reads, qc and create OTU table 
rule get_otutable:
	input:
		script="code/bash/mothurShared.sh",
        "data/mothur/process/test.files",
		raw=expand('data/mothur/raw/{mothurSamples}_{readNum}_001.fastq.gz',
			mothurSamples = mothurSamples, readNum = config["readNum"]),
		refs=rules.get_mothur_references.output,
	output:
		taxonomy="data/mothur/process/falinal.taxonomy",    
		shared="data/mothur/process/fin.shared",
		errorFasta="data/mothur/process/error_analysis/errorinput.fasta",
		errorCount="data/mothur/process/error_analysis/errorinput.count_table"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} data/mothur/raw/ {input.refs}"


# Splitting master shared file into individual shared file for: i) samples, ii) controls, and iii) mocks.
# This is used for optimal subsampling during downstream steps.
rule split16SShared:
	input:
		script="code/bash/mothurSplitShared.sh",
		shared=rules.make16SShared.output.shared
	output:
		shared=expand("data/mothur/process/{group}.final.shared",
			group = config["mothurGroups"])
	params:
		mockGroups='-'.join(config["mothurMock"]), # Concatenates all mock group names with hyphens
		controlGroups='-'.join(config["mothurControl"]) # Concatenates all control group names with hyphens
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {params.mockGroups} {params.controlGroups}"


# Counting number of reads in each of the new shared files.
rule count16SShared:
	input:
		script="code/bash/mothurCountShared.sh",
		shared="data/mothur/process/{group}.final.shared"
	output:
		countout="data/mothur/process/{group}.final.count.summary"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.shared}"


# Uses read counts to subsample shared files to the largest number of reads above a given read
# threshold denoted as 'subthresh'.
rule subsample16SShared:
	input:
		script="code/bash/mothurSubsampleShared.sh",
		shared="data/mothur/process/{group}.final.shared",
		countout="data/mothur/process/{group}.final.count.summary"
	output:
		subsampleShared="data/mothur/process/{group}.final.0.03.subsample.shared"
	params:
		subthresh=config["subthresh"]
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.shared} {input.count} {params.subthresh}"





##################################################################
#
# Part 3: Diversity Metrics 
#
##################################################################

rule rarefy16SReads:
	input:
		script="code/bash/mothurRarefaction.sh",
		shared="data/mothur/process/sample.final.shared"
	output:
		rarefaction="data/mothur/process/sample.final.groups.rarefaction"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.shared}"


# Calculating alpha diversity metrics (within sample diversity).
rule calc16SAlphaDiversity:
	input:
		script="code/bash/mothurAlpha.sh",
		shared="data/mothur/process/sample.final.shared",
		countout="data/mothur/process/sample.final.count.summary"
	output:
		alpha="data/mothur/process/sample.final.groups.ave-std.summary"
	params:
		subthresh=config["subthresh"],
		alpha='-'.join(config["mothurAlpha"]) # Concatenates all alpha metric names with hyphens
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.shared} {input.count} {params.subthresh} {params.alpha}"


# Calculating beta diversity metrics (between sample diversity).
rule calc16SBetaDiversity:
	input:
		script="code/bash/mothurBeta.sh",
		shared="data/mothur/process/sample.final.shared",
		countout="data/mothur/process/sample.final.count.summary"
	output:
		dist=expand("data/mothur/process/sample.final.{beta}.0.03.lt.ave.dist",
			beta = config["mothurBeta"])
	params:
		subthresh=config["subthresh"],
		beta='-'.join(config["mothurBeta"]) # Concatenates all beta metric names with hyphens
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.shared} {input.count} {params.subthresh} {params.beta}"





##################################################################
#
# Part 4: Ordination 
#
##################################################################

# Calculates principal coordinate analysis (PCoA) ordination for visualizing beta diversity.
rule calc16SPCoA:
	input:
		script="code/bash/mothurPCoA.sh",
		dist="data/mothur/process/sample.final.{beta}.0.03.lt.ave.dist"
	output:
		loadings="data/mothur/process/sample.final.{beta}.0.03.lt.ave.pcoa.loadings",
		axes="data/mothur/process/sample.final.{beta}.0.03.lt.ave.pcoa.axes"
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.dist}"


# Calculates non-metric multi-dimensional scaling (NMDS) ordination for visualizing beta diversity. 
rule calc16SNMDS:
	input:
		script="code/bash/mothurNMDS.sh",
		dist="data/mothur/process/sample.final.{beta}.0.03.lt.ave.dist"
	output:
		stress="data/mothur/process/sample.final.{beta}.0.03.lt.ave.nmds.stress",
		axes="data/mothur/process/sample.final.{beta}.0.03.lt.ave.nmds.axes"
	params:
		seed=config["seed"]
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.dist} {params.seed}"





##################################################################
#
# Part 5: Quality Control 
#
##################################################################

# Calculates estimated sequencing error rate based on mock sequences.
rule calc16SError:
	input:
		script="code/bash/mothurError.sh",
		errorFasta=rules.make16SShared.output.errorFasta,
		errorCount=rules.make16SShared.output.errorCount,
		mockV4=rules.get16SMock.output.mockV4
	output:
		summary="data/mothur/process/error_analysis/errorinput.pick.error.summary"
	params:
		mockGroups='-'.join(config["mothurMock"]) # Concatenates all mock group names with hyphens
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script} {input.errorFasta} {input.errorCount} {input.mockV4} {params.mockGroups}"





##################################################################
#
# Part 6: Cleaning 
#
##################################################################

# Resets directory by deleting all files created by this workflow.
rule clean:
	shell:
		"""
		echo PROGRESS: Removing all workflow output.
		rm -rf data/mothur/references/ data/mothur/process/
		"""
