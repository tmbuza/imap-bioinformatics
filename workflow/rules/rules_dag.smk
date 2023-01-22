from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule get_dag:
	output:
		"dags/rulegraph.svg",
		"dags/rulegraph.png",
		"dags/dag.svg",
		"dags/dag.png"
	shell:
		"bash workflow/scripts/rules_dag.sh"
