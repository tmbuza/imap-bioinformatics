#!/bin/bash

# Generate interactive html report
snakemake --report report.zip

unzip -o report.zip 
rm report.zip
