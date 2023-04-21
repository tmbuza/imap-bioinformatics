OUTDIR="data/reads"  

SAMPLES = list(set(glob_wildcards(os.path.join('data/reads', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))
# SAMPLES = list(set(glob_wildcards(os.path.join('data/reads', '{sample}_{sradNum, [12]}.fastq.gz')).sample))

rule import_reads:
    output:
        expand('{outdir}/{sample}_{readNum}_001.fastq.gz', outdir=OUTDIR, sample=SAMPLES, readNum=config["readNum"]),
    shell:
        "bash workflow/scripts/import_data.sh"


rule import_metadata:
    output:
        "data/metadata/test.files"
    shell:
        "bash workflow/scripts/import_data.sh"

# Downloading and formatting SILVA and RDP reference databases. The v4 region is extracted from 
# SILVA database for use as reference alignment.
rule get_mothur_references:
	output:
		silvaV4="data/references/silva.v4.align",
		rdpFasta="data/references/trainset16_022016.pds.fasta",
		rdpTax="data/references/trainset16_022016.pds.tax"
	conda:
		"../envs/mothur.yml"
	shell:
		"bash workflow/scripts/mothurReferences.sh"


# Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
rule get_mothur_zymo_mock:
	input:
		script="workflow/scripts/mothurMock.sh",
		silvaV4="data/references/silva.v4.align",
	output:
		mockV4="data/references/zymo.mock.16S.v4.fasta"
	conda:
		"../envs/mothur.yml"
	shell:
		"bash {input.script}"

# Generating master OTU shared file.

# Making mothur-based sample mapping file.
rule mothur_mapping_files:
    input:
        script="workflow/scripts/makeFile.sh",
        reads=expand('{outdir}/{sample}_{readNum}_001.fastq.gz', outdir=OUTDIR, sample=SAMPLES, readNum=config["readNum"])
    output:
        expand("mothur_process/{dataset}.files", dataset=config["dataset"]),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"



rule mothur_process_sequences:
    input:
        "data/metadata/test.files",
        expand("mothur_process/{dataset}.files", dataset=config["dataset"]),
        script="workflow/scripts/mothur_process_seqs.sh",
        silvaV4="data/references/silva.v4.align",
        rdpFasta="data/references/trainset16_022016.pds.fasta",
        rdpTax="data/references/trainset16_022016.pds.tax",
    output:
        fasta="mothur_process/final.fasta",
        ctable="mothur_process/final.count_table",
        taxonomy="mothur_process/final.taxonomy",
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"

# Preparing final processed fasta and count table.
rule mothur_final_processed_seqs:
	input:
		script="workflow/scripts/mothur_final_processed_seqs.sh",
		metadata=rules.mothur_process_sequences.output
	output:
		fasta="mothur_process/{method}/final.fasta",
		ctable="mothur_process/{method}/final.count_table",
		taxonomy="mothur_process/{method}/final.taxonomy",
	conda:
		"../envs/mothur.yml"
	shell:
		"bash {input.script}"


# Classify OTUS
rule mothur_classify_otus:
    input:
        script="workflow/scripts/mothur_classify_otus.sh",
        infiles=expand(rules.mothur_final_processed_seqs.output, method="otu_analysis"),
    output:
        dist=expand("mothur_process/{method}/final.dist", method="otu_analysis"),
        fasta=expand("mothur_process/{method}/final.opti_mcc.0.03.rep.fasta", method="otu_analysis"),
        mcclist=expand("mothur_process/{method}/final.opti_mcc.list", method="otu_analysis"),
        shared=expand("mothur_process/{method}/final.opti_mcc.shared", method="otu_analysis"),
        taxonomy=expand("mothur_process/{method}/final.pds.wang.pick.taxonomy", method="otu_analysis"),
        constaxonomy=expand("mothur_process/{method}/final.opti_mcc.0.03.cons.taxonomy", method="otu_analysis"),
        ctable=expand("mothur_process/{method}/final.opti_mcc.0.03.rep.count_table", method="otu_analysis"),
        biom=expand("mothur_process/{method}/final.opti_mcc.0.03.biom", method="otu_analysis"),
        lefse=expand("mothur_process/{method}/final.opti_mcc.0.03.lefse", method="otu_analysis"),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"


# Classify Phylotypes
rule mothur_classify_phylotype:
    input:
        script="workflow/scripts/mothur_classify_phylotypes.sh",
        infiles=expand(rules.mothur_final_processed_seqs.output, method="phylotype_analysis"),
    output:
        txlist=expand("mothur_process/{method}/final.pds.wang.pick.tx.list", method="phylotype_analysis"),
        rabund=expand("mothur_process/{method}/final.pds.wang.pick.tx.rabund", method="phylotype_analysis"),
        sabund=expand("mothur_process/{method}/final.pds.wang.pick.tx.sabund", method="phylotype_analysis"),
        shared=expand("mothur_process/{method}/final.pds.wang.pick.tx.shared", method="phylotype_analysis"),
        taxonomy=expand("mothur_process/{method}/final.pds.wang.pick.taxonomy", method="phylotype_analysis"),
        constaxonomy=expand("mothur_process/{method}/final.pds.wang.pick.tx.1.cons.taxonomy", method="phylotype_analysis"),
        biom=expand("mothur_process/{method}/final.pds.wang.pick.tx.1.lefse", method="phylotype_analysis"),
        lefse=expand("mothur_process/{method}/final.pds.wang.pick.tx.1.biom", method="phylotype_analysis"),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"


    # Classify Phylotypes
rule mothur_classify_asvs:
    input:
        script="workflow/scripts/mothur_classify_asvs.sh",
        infiles=expand(rules.mothur_final_processed_seqs.output, method="asv_analysis"),
    output:
        asvlist=expand("mothur_process/{method}/final.asv.list", method="asv_analysis"),
        shared=expand("mothur_process/{method}/final.asv.shared", method="asv_analysis"),
        constaxonomy=expand("mothur_process/{method}/final.asv.ASV.cons.taxonomy", method="asv_analysis"),
        biom=expand("mothur_process/{method}/final.asv.ASV.biom", method="asv_analysis"),
        lefse=expand("mothur_process/{method}/final.asv.ASV.lefse", method="asv_analysis"),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"


    # Classify Phylotypes
rule mothur_classify_phylogeny:
    input:
        script="workflow/scripts/mothur_classify_phylogeny.sh",
        infiles=expand(rules.mothur_final_processed_seqs.output, method="phylogeny_analysis"),
    output:
        phylip=expand("mothur_process/{method}/final.phylip.dist", method="phylogeny_analysis"),
        taxonomy=expand("mothur_process/{method}/final.pds.wang.pick.taxonomy", method="phylogeny_analysis"),
        tree=expand("mothur_process/{method}/final.phylip.tre", method="phylogeny_analysis"),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script}"

# Calculate estimated sequencing error rate based on mock sequences.
rule mothur_error_rate:
    input:
        script="workflow/scripts/mothur_error_rate.sh",
        infiles=expand(rules.mothur_final_processed_seqs.output, method="error_analysis"),
        mockV4=rules.get_mothur_zymo_mock.output.mockV4
    output:
        expand("mothur_process/{method}/final.pick.error.summary", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.seq", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.chimera", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.seq.forward", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.seq.reverse", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.count", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.matrix", method="error_analysis"),
        expand("mothur_process/{method}/final.pick.error.ref", method="error_analysis"),
    params:
        mockGroups='-'.join(config["mothurMock"]) # Concatenates all mock group names with hyphens
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script} {input.infiles} {input.mockV4} {params.mockGroups}"



# Splitting master shared file into individual shared file for: i) samples, ii) controls, and iii) mocks.
# This is used for optimal subsampling during downstream steps.
rule mothur_split_group_shared:
	input:
		script="workflow/scripts/mothur_split_otutable.sh",
		shared=rules.mothur_classify_otus.output
	output:
		shared=expand("mothur_process/{method}/{group}.final.shared", method="otu_analysis", group=config["mothurGroups"])
	params:
		mockGroups='-'.join(config["mothurMock"]), # Concatenates all mock group names with hyphens
		controlGroups='-'.join(config["mothurControl"]) # Concatenates all control group names with hyphens
	conda:
		"../envs/mothur.yml"
	shell:
		"bash {input.script} {params.mockGroups} {params.controlGroups}"


# Diversity Metrics 

rule alpha_beta_diversity:
    input:
        script="workflow/scripts/mothur_diversity_analysis.sh",
        shared=rules.mothur_split_group_shared.output
    output:
        expand("mothur_process/{method}/sample.final.count.summary", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.0.03.subsample.shared", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.groups.summary", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.groups.rarefaction", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.sharedsobs.0.03.lt.dist", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.thetayc.0.03.lt.dist", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.dist", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.tre", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.pcoa.axes", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.pcoa.loadings", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.nmds.iters", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.nmds.stress", method="otu_analysis"),
        expand("mothur_process/{method}/sample.final.braycurtis.0.03.lt.nmds.axes", method="otu_analysis"),
    conda:
        "../envs/mothur.yml"
    shell:
        "bash {input.script} {input.shared}"