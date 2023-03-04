import os
import glob
import csv
import pandas as pd


# Create samples file. Here we are selecting the sample ID column and another column as condition. Users can pick any column of interest and must be present in their dataset.

samples=pd.read_csv('data/metadata/metadata.csv')[['sample_id', 'isolate']].rename(columns={
    "sample_id": "sample_name", 
    "isolate": "animal"})
samples.to_csv("config/samples.tsv",index=False, sep="\t")


# Create units file
units=pd.read_csv('data/metadata/metadata.csv').rename(
    columns={
        "sample_id": "sample_name", 
        "ecosystem": "condition",
        "isolate": "animal"})
units.to_csv("config/units.tsv",index=False, sep="\t")


