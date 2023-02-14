#! /bin/bash
# mothurError.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
REFSDIR="data/mothur/references"
ERRORDIR="data/mothur/final/error_analysis"
ERRORFASTA="errorinput.fasta"
ERRORCOUNT="errorinput.count_table"
MOCKV4="zymo.mock.16S.v4.fasta"
MOCKGROUPS="Mock1-Mock2" # List of mock groups in raw data dir separated by '-'


######################
# Run Error Analysis #
######################

# Calculating error rates compared to Zymo reference sequences
echo PROGRESS: Calculating sequencing error rate.

mothur "#set.logfile("${LOGS}"/error_analysis.logfile);
	set.current(fasta="${ERRORDIR}"/"${ERRORFASTA}" count="${ERRORDIR}"/"${ERRORCOUNT}");
	
	get.groups(fasta=current, count=current, groups="${MOCKGROUPS}");
	seq.error(fasta=current, count=current, reference="${REFSDIR}"/"${MOCKV4}", aligned=F)"
