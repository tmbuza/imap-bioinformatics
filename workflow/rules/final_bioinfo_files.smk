rule final_otu_files:
    input:
        script="workflow/scripts/final_bioinfo_files.sh",
        shared=expand(rules.classify_otu97.output, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        "{finalotus}/final.list",
        "{finalotus}/final.shared",
        "{finalotus}/final.steps",
        "{finalotus}/final.sensspec",
        "{finalotus}/final.cons.taxonomy",
        "{finalotus}/final.cons.tax.summary",
        "{finalotus}/final.rep.fasta",
        "{finalotus}/final.rep.count_table",
        "{finalotus}/final.lefse",
        "{finalotus}/final.biom",
    shell:
        "bash  {input.script}"


rule final_phylotype_files:
    input:
        script="workflow/scripts/final_bioinfo_files.sh",
        shared=expand(rules.classify_phylotype.output, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        "{finalphylotype}/final.tx.list",
        "{finalphylotype}/final.tx.rabund",
        "{finalphylotype}/final.tx.sabund",
        "{finalphylotype}/final.tx.shared",
        "{finalphylotype}/final.tx.cons.taxonomy",
        "{finalphylotype}/final.tx.cons.tax.summary",
        "{finalphylotype}/final.tx.lefse",
        "{finalphylotype}/final.tx.biom",
    shell:
        "bash  {input.script}"


rule final_asv_files:
    input:
        script="workflow/scripts/final_bioinfo_files.sh",
        shared=expand(rules.classify_asv.output, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        "{finalasv}/final.asv.list",
        "{finalasv}/final.asv.shared",
        "{finalasv}/final.asv.cons.taxonomy",
        "{finalasv}/final.asv.cons.tax.summary",
        "{finalasv}/final.asv.lefse",
        "{finalasv}/final.asv.biom",
    shell:
        "bash  {input.script}"


rule final_phylogeny_files:
    input:
        script="workflow/scripts/final_bioinfo_files.sh",
        fasta=expand(rules.classify_phylogeny.output, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        "{finalphylogeny}/final.phylip.dist",
        "{finalphylogeny}/final.phylip.tre",
    shell:
        "bash  {input.script}"
