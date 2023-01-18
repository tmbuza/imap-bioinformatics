from snakemake.utils import min_version

min_version("6.10.0")


# rule all:
#     input:
#         "dags/rulegraph.svg",
#         "report/report.html",
#         "index.html",  

rule get_dag:
    input:
        script="workflow/scripts/rulegraph.sh"
    output:
        "dags/rulegraph.svg",
    shell:
        "bash {input.script}"


rule ghp_index:
    input:
        rmd="index.Rmd",
        rulegraph="dags/rulegraph.svg",
    output:
        "index.html",
    log:
        "logs/render_index.log",
    shell:
        """
        R -e "library(rmarkdown); render('{input.rmd}')"
        """

rule interactive_report:
    input:
        script="workflow/scripts/interactive_report.sh"
    output:
        "report/report.html",
    shell:
        "bash {input.script}"