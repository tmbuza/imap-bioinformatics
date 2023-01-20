rule final_bioinfo_files:
    input:
        script="workflow/scripts/final_bioinfo_files.sh",
        shared=expand(rules.classify_otu97.output, outdir=config["outdir"], dataset=config["dataset"]),
    output:
        "data/mothur/process/final.list",
        "data/mothur/process/final.shared",
        "data/mothur/process/final.steps",
        "data/mothur/process/final.sensspec",
        "data/mothur/process/final.cons.taxonomy",
        "data/mothur/process/final.cons.tax.summary",
        "data/mothur/process/final.rep.fasta",
        "data/mothur/process/final.rep.count_table",
        "data/mothur/process/final.lefse",
        "data/mothur/process/final.biom",
    shell:
        "bash  {input.script}"
