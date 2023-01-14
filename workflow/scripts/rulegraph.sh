#!/usr/bin/env bash

set -ev

mkdir -p dags

# snakemake -F --rulegraph  targets | dot -Tsvg > dags/rulegraph.svg
# snakemake -F --rulegraph  targets | dot -Tpng > dags/rulegraph.png
# snakemake -F --dag  targets | dot -Tsvg > dags/dag.svg
# snakemake -F --dag  targets | dot -Tpng > dags/dag.png

snakemake -F --rulegraph  all | dot -Tsvg > dags/rulegraph.svg
snakemake -F --rulegraph  all | dot -Tpng > dags/rulegraph.png
snakemake -F --dag  all | dot -Tsvg > dags/dag.svg
snakemake -F --dag  all | dot -Tpng > dags/dag.png

# snakemake -F --rulegraph  Output_Files | dot -Tsvg > dags/rulegraph.svg
# snakemake -F --rulegraph  Output_Files | dot -Tpng > dags/rulegraph.png
# snakemake -F --dag  Output_Files | dot -Tsvg > dags/dag.svg
# snakemake -F --dag  Output_Files | dot -Tpng > dags/dag.png

snakemake --rulegraph --snakefile workflow/rules/summary.smk | dot -Tpng >dags/summary_report_dag.png
snakemake --rulegraph --snakefile workflow/rules/summary.smk | dot -Tpng >dags/summary_report_dag.svg