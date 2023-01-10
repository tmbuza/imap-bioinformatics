from snakemake.utils import min_version

min_version("6.10.0")


rule REPORTS:
    input:
        "dags/rulegraph.svg",
        "dags/rulegraph.png",
        "dags/dag.svg",
        "dags/dag.png",
        "report/report.html",
        "index.html"

include: "rules_dag.smk"
include: "interactive_report.smk"
include: "render_index.smk"

# rule get_dag:
# 	output:
# 		"dags/rulegraph.svg",
# 		"dags/rulegraph.png",
# 		"dags/dag.svg",
# 		"dags/dag.png"
# 	shell:
# 		"bash workflow/scripts/rulegraph.sh"


# rule interactive_report:
# 	output:
# 		"report/report.html",
# 	shell:
# 		"bash workflow/scripts/report.sh"


# rule render_index:
#     input:
#         rmd="index.Rmd",
#         rulegraph="dags/rulegraph.svg",
#         dag="dags/dag.svg"
#     output:
#         "index.html",
#     log:
#         "logs/render_index.log",
#     shell:
#         """
#         R -e "library(rmarkdown); render('{input.rmd}')"
#         """