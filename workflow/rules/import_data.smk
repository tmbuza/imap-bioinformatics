# Import reads

rule import_reads:
    output:
        gzfq=expand('{outdir}/{sample}_{readNum}_001.fastq.gz', outdir=OUTDIR, sample=SAMPLES, readNum=config["readNum"]),
    shell:
        "bash workflow/scripts/import_data.sh"


rule import_metadata:
    output:
        "data/metadata/test.files"
    shell:
        "bash workflow/scripts/import_data.sh"

