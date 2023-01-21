rule classify_phylogeny:
    input: 
        script="workflow/scripts/classify_phylogeny.sh",
        fasta=expand(rules.denoise_n_classify80.output.fasta, outdir=config["outdir"], dataset=config["dataset"]),
    output: 
        phylipdist="data/mothur/final/phylogeny_analysis/final.rep.phylip.dist",
        phyliptre="data/mothur/final/phylogeny_analysis/final.rep.phylip.tre",
    threads: 2
    shell:
        "bash {input.script} {threads}"
        
        