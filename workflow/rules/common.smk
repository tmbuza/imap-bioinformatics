import pandas as pd
from snakemake.utils import validate
from snakemake.utils import min_version

min_version("5.18.0")

report: "../report/workflow.rst"

container: "continuumio/miniconda3:4.8.2"

configfile: "config/config.yml"

import os
import csv
import pandas as pd

METADATA = (
    pd.read_csv(config["samples"], sep="\t", dtype={"group": str})
    .set_index("group", drop=False)
    .sort_index()
)

SAMPLES = METADATA["group"]

OUTDIR="data/reads"  

SAMPLES = list(set(glob_wildcards(os.path.join('data/reads', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

if not os.path.exists(OUTDIR): os.makedirs(OUTDIR)


