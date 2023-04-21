import os
import csv
import pandas as pd

METADATA = (
    pd.read_csv(config["samples"], sep="\t", dtype={"group": str})
    .set_index("group", drop=False)
    .sort_index()
)

GROUP = METADATA["group"]

PREFIX = ["count_table", "fasta", "map"]

# rule all:
#     input: 
#         expand("mothur_process/intermediate/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.{sample}.{prefix}", 
#         outdir=OUTDIR, 
#         dataset=config["dataset"], 
#         sample=GROUP, 
#         prefix=PREFIX)

rule remove_intermediate_files:
    input: 
        rules.mothur_process_sequences.output
        # expand("mothur_process/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.{sample}.{prefix}", 
        # outdir=OUTDIR, 
        # dataset=config["dataset"], 
        # sample=GROUP, 
        # prefix=PREFIX)
    output: 
        expand("mothur_process/intermediate/{dataset}.trim.contigs.good.unique.good.filter.unique.precluster.{sample}.{prefix}", 
        outdir=OUTDIR, 
        dataset=config["dataset"], 
        sample=GROUP, 
        prefix=PREFIX)
    shell:
        "bash workflow/scripts/remove_intermediate_files.sh"