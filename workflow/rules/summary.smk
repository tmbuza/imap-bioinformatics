rule get_dag:
    input:
        script="workflow/scripts/rulegraph.sh"
    output:
        "dags/rulegraph.svg",
        "dags/rulegraph.png",
        "dags/dag.svg",
        "dags/dag.png",
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


rule summary_report:
    input:
        script="workflow/scripts/summary.sh"
    output:
        "dags/rulegraph.svg",
        "dags/rulegraph.png",
        "dags/dag.svg",
        "dags/dag.png",
        "index.html"
        "report/report.html",
    shell:
        "bash {input.script}"