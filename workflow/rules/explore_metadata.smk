 from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

 
rule get_metadata:
        input:
                script = "workflow/scripts/explore_metadata.R"
        output:
                "data/metadata/metadata.csv"
        shell:
                "{input.script}"
      
  
rule plot_varfreq:
        input:
                script = "workflow/scripts/explore_metadata.R",
                csv="data/metadata/metadata.csv"
        output:
                "images/variables.png"
        shell:
                "{input.script}"