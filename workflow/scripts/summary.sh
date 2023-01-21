#!/usr/bin/env bash

# bash workflow/scripts/rulegraph.sh

# bash workflow/scripts/interactive_report.sh

# snakemake -c3 --snakefile workflow/rules/summary.smk

snakemake --rulegraph  all | dot -Tsvg > dags/rulegraph.svg
snakemake --rulegraph  all | dot -Tpng > dags/rulegraph.png
snakemake --dag  all | dot -Tsvg > dags/dag.svg
snakemake --dag  all | dot -Tpng > dags/dag.png

snakemake -c3 index.html

snakemake --report report.zip
unzip -o report.zip 
rm report.zip
