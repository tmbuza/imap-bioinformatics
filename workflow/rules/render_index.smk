rule ghp_index:
    input:
        rmd="index.Rmd",
        rulegraph="dags/rulegraph.svg",
        dag="dags/dag.svg"
    output:
        doc="index.html",
    log:
        "logs/render_index.log",
    shell:
        """
        R -e "library(rmarkdown); render('{input.rmd}')"
        """

