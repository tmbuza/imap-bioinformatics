**Mothur & QIIME2 bioinformatics snakemake workflow**::

    Mothur pipeline performs the following tasks:
        - Assembles and screens the qced reads.
        - Aligns representative sequences to a reference.
        - Denoises and removes chimeras and non-bacterial sequences.
        - Taxonomically, classifies the representative sequences.
        - Cluster OTUs and assign taxonomic names.
        - Generate the OTU table known as shared table in mothur.
        - Calculates sequencing error rate.
        - Performs preliminary analysis of OTU abundances.
        - Generates snakemake interactive report and
        - Finally, it deploys a user-generated report to GitHub pages. 
    
    QIIME 2 pipeline performs the following tasks:
    ---IN PROGRESS--- 