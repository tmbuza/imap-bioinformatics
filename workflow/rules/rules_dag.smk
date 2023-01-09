# rule target:
# 	input:
# 		"dags/rulegraph.svg",
# 		"dags/rulegraph.png",
# 		"dags/dag.svg",
# 		"dags/dag.png",

rule get_dag:
	output:
		"dags/rulegraph.svg",
		"dags/rulegraph.png",
		"dags/dag.svg",
		"dags/dag.png"
	shell:
		"bash workflow/scripts/rulegraph.sh"
