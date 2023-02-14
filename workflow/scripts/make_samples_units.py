import os
import glob
import csv
import pandas as pd


# Create samples file
samples=pd.read_csv('data/metadata/metadata.csv')[['sample_id', 'isolate']].rename(
    columns={
        "sample_id": "sample_name", 
        "isolate": "animal"})

print(samples)
samples.to_csv("config/samples.tsv",index=False, sep="\t")


# Create units file
units=pd.read_csv('data/metadata/metadata.csv').rename(
    columns={
        "sample_id": "sample_name", 
        "ecosystem": "condition",
        "isolate": "animal"})

print(units)
units.to_csv("config/units.tsv",index=False, sep="\t")


