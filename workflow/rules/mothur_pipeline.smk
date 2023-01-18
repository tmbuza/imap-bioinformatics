from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Function for aggregating list of raw sequencing files.
mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

sraSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{sraNum, [12]}.fastq.gz')).sample))


rule all:
    input:
        # make_files.smk
        expand("{outdir}/{dataset}.files", outdir=config["outdir"], dataset=config["dataset"]),

        # get_references.smk
        "data/mothur/references/silva.seed.align",
        "data/mothur/references/silva.v4.align",
        "data/mothur/references/trainset16_022016.pds.fasta",
        "data/mothur/references/trainset16_022016.pds.tax",
        "data/mothur/references/zymo.mock.16S.v4.fasta"

        # summary.smk
        "dags/rulegraph.svg",
        "report/report.html",
        "index.html"



include: "get_references.smk"
include: "make_files.smk"
include: "summary.smk"


# rule make_files:
#     input:
#         script="workflow/scripts/make_files.sh",
#     output:
#         files="{outdir}/{dataset}.files",
#     shell:
#         "bash {input.script}"


# rule make_contigs:
#     input:
#         script="workflow/scripts/make_contigs.sh",
#         files=rules.make_files.output.files,
#         raw=expand("{outdir}/{mothurSamples}_{readNum}_001.fastq.gz", mothurSamples = mothurSamples, readNum = config["readNum"]),
#     output:
#         fasta = "{outdir}/{dataset}.trim.contigs.fasta",
#     threads: 2
#     shell:
#         "bash {input.script} {input.files}"


# rule screen:
#     input: test.contigs.groups, test.trim.contigs.fasta
#     output: test.trim.contigs.good.fasta, test.contigs.good.groups
#     shell: "mothur #screen.seqs(fasta=test.trim.contigs.fasta, group=test.contigs.groups, maxambig=0, maxlength=275)"
        
# rule unique:
#     input: test.trim.contigs.good.fasta
#     output: test.trim.contigs.good.names, test.trim.contigs.good.unique.fasta
#     shell: "mothur #unique.seqs(fasta=test.trim.contigs.good.fasta)"
        
# rule pcr:
#     input: silva.bacteria/silva.bacteria.fasta
#     output: silva.bacteria/silva.bacteria.pcr.fasta
#     shell: "mothur #pcr.seqs(fasta=silva.bacteria/silva.bacteria.fasta,start=11894, end=25319, keepdots=F)"
        
# rule count:
#     input: test.trim.contigs.good.names, test.contigs.good.groups
#     output: test.trim.contigs.good.count_table
#     shell: "mothur #count.seqs(name=test.trim.contigs.good.names, group=test.contigs.good.groups)"
        
# rule align:
#     input: test.trim.contigs.good.unique.fasta, silva.bacteria/silva.bacteria.pcr.fasta
#     output: test.trim.contigs.good.unique.align
#     shell: "mothur #align.seqs(fasta=test.trim.contigs.good.unique.fasta,reference=silva.bacteria/silva.bacteria.pcr.fasta)"
        
# rule summary:
#     input: test.trim.contigs.good.count_table, test.trim.contigs.good.unique.align
#     output: test.trim.contigs.good.unique.summary, test.summary.txt
#     shell: "mothur #summary.seqs(fasta=test.trim.contigs.good.unique.align, count=test.trim.contigs.good.count_table)" 
        
# rule screen2:
#     input: test.trim.contigs.good.unique.summary, test.trim.contigs.good.count_table, test.trim.contigs.good.unique.align
#     output: test.trim.contigs.good.unique.good.align, test.trim.contigs.good.good.count_table

# rule filter:
#     input: test.trim.contigs.good.unique.good.align
#     output: test.trim.contigs.good.unique.good.filter.fasta
#     shell: "mothur #filter.seqs(fasta=test.trim.contigs.good.unique.good.align, vertical=T, trump=.)"
        
# rule unique2:
#     input: test.trim.contigs.good.good.count_table, test.trim.contigs.good.unique.good.filter.fasta
#     output: test.trim.contigs.good.unique.good.filter.count_table, test.trim.contigs.good.unique.good.filter.unique.fasta
#     shell: "mothur #unique.seqs(fasta=test.trim.contigs.good.unique.good.filter.fasta, count=test.trim.contigs.good.good.count_table)"
        
# rule pre_cluster:
#     input: test.trim.contigs.good.unique.good.filter.count_table, test.trim.contigs.good.unique.good.filter.unique.fasta
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.fasta, test.trim.contigs.good.unique.good.filter.unique.precluster.count_table
#     log: logs/precluster/test.log
#     shell: "mothur #pre.cluster(fasta=test.trim.contigs.good.unique.good.filter.unique.fasta, count=test.trim.contigs.good.unique.good.filter.count_table, diffs=2)"
        
# rule chimera_uchime:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.count_table, test.trim.contigs.good.unique.good.filter.unique.precluster.fasta
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.accnos, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.count_table
#     shell: "mothur #chimera.uchime(fasta=test.trim.contigs.good.unique.good.filter.unique.precluster.fasta, count=test.trim.contigs.good.unique.good.filter.unique.precluster.count_table, dereplicate=t)"
        
# rule remove:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.fasta, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.accnos
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta
#     shell: "mothur #remove.seqs(fasta=test.trim.contigs.good.unique.good.filter.unique.precluster.fasta, accnos=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.accnos)"
        
# rule classify:
#     input: trainset9_032012.pds.tax, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.count_table, trainset9_032012.pds.fasta, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.taxonomy
#     shell: "mothur #classify.seqs(fasta=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.count_table, reference=trainset9_032012.pds.fasta, taxonomy=trainset9_032012.pds.tax, cutoff=80)"
        
# rule remove_lineage:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.taxonomy, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.count_table, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.count_table
#     log: logs/remove_lineage/test.log
#     shell: "mothur #remove.lineage(fasta=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.count_table, taxonomy=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.taxonomy, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)"
        
# rule remove_groups:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.count_table, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.pick.count_table, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy
#     shell: "mothur #remove.groups(count=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.count_table, fasta=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, taxonomy=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy, groups=Mock);"
        
# rule phylotype:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list
#     shell: "mothur #phylotype(taxonomy=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy)"
        
# rule analysis:
#     input: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list, test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.pick.count_table, test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy
#     output: test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.cons.taxonomy
#     shell: "mothur #make.shared(list=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list, count=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.pick.count_table, label=1); classify.otu(list=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list, count=test.trim.contigs.good.unique.good.filter.unique.precluster.uchime.pick.pick.pick.count_table, taxonomy=test.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy, label=1);"
        
# rule report:
#     input:
#         "dags/rulegraph.svg",
#         "dags/rulegraph.png",
#         "dags/dag.svg",
#         "dags/dag.png",
#         "report/report.html",
#         "index.html"

