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
        "{finalphylotype}/final.final.tx.sabund",
        "{finalphylotype}/final.final.tx.shared",
        "{finalphylotype}/final.final.tx.cons.taxonomy",
        "{finalphylotype}/final.final.tx.lefse",
        "{finalphylotype}/final.final.tx.biom",
    shell:
        "bash  {input.script}"
