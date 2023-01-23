from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule classify_phylogeny:
    input: 
        script="workflow/scripts/classify_phylogeny.sh",
        fasta="data/mothur/process/test.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta",
    output: 
        phylipdist="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.phylip.dist",
        phyliptre="{outdir}/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.phylip.tre",
    threads: 2
    shell:
        "bash {input.script} {threads}"
              