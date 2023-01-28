#!/usr/bin/env bash

set -ev

mkdir -p dags

# snakemake -F --rulegraph  targets | dot -Tsvg > dags/rulegraph.svg
# snakemake -F --rulegraph  targets | dot -Tpng > dags/rulegraph.png
# snakemake -F --dag  targets | dot -Tsvg > dags/dag.svg
# snakemake -F --dag  targets | dot -Tpng > dags/dag.png

snakemake -F --rulegraph | dot -Tsvg > dags/imap2.svg
snakemake -F --rulegraph | dot -Tpng > dags/rulegraph.svg
snakemake -F --rulegraph | dot -Tpng > dags/rulegraph.png
snakemake -F --dag | dot -Tsvg > dags/dag.svg
snakemake -F --dag | dot -Tpng > dags/dag.png

# snakemake -F --rulegraph  Output_Files | dot -Tsvg > dags/rulegraph.svg
# snakemake -F --rulegraph  Output_Files | dot -Tpng > dags/rulegraph.png
# snakemake -F --dag  Output_Files | dot -Tsvg > dags/dag.svg
# snakemake -F --dag  Output_Files | dot -Tpng > dags/dag.png

# snakemake --rulegraph --snakefile workflow/rules/get_references.smk | dot -Tpng >dags/references_dag.png
# snakemake --rulegraph --snakefile workflow/rules/get_references.smk | dot -Tpng >dags/references_dag.svg

# snakemake --rulegraph --snakefile workflow/rules/rules_dag.smk | dot -Tpng >dags/rules_dag_report_dag.png
# snakemake --rulegraph --snakefile workflow/rules/rules_dag.smk | dot -Tpng >dags/rules_dag_report_dag.svg

# snakemake --rulegraph --snakefile workflow/rules/summary.smk | dot -Tpng >dags/summary_report_dag.png
# snakemake --rulegraph --snakefile workflow/rules/summary.smk | dot -Tpng >dags/summary_report_dag.svg