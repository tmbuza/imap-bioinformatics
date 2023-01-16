#! /bin/bash

# denoise_n_classify.sh

CLASSIFIER="trainset16_022016.pds.fasta"
TAXONOMY="trainset16_022016.pds.tax"

OUTDIR="data/mothur/process"
DBREFSDIR="data/mothur/references"

FASTA="test.trim.contigs.good.unique.good.filter.unique.fasta"
COUNT="test.trim.contigs.good.unique.good.filter.count_table"

LOGS="data/mothur/logs"

echo PROGRESS: Aligning and filtering bad alignments.

mkdir -p "${OUTDIR}" 
	
mothur "#
    set.logfile(name=${LOGS}/denoise_n_classify.logfile);
	set.current(fasta=${OUTDIR}/${FASTA}, count=${OUTDIR}/${COUNT});

	pre.cluster(fasta=current, count=current, diffs=2);

	set.logfile(name=name=${LOGS}/chimera_removal.logfile);
	chimera.vsearch(fasta=current, count=current, dereplicate=t);

	set.logfile(name=name=${LOGS}/classify_seq.logfile);
	classify.seqs(fasta=current, count=current, reference=${DBREFSDIR}/${CLASSIFIER}, taxonomy=${DBREFSDIR}/${TAXONOMY}, cutoff=97);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
  
    set.logfile(name=${LOGS}/cluster_n_classify.logfile);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"

	
# Renaming output files for use later
# mv ${OUTDIR}/*.precluster*pick.fasta ${ERRORDIR}/errorinput.fasta
# mv ${OUTDIR}/*.vsearch*.pick.count_table ${ERRORDIR}"/errorinput.count_table
mv "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
mv "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
mv "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
mv "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
mv "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table
mv "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
mv "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


###############
# Cleaning Up #
###############

echo PROGRESS: Cleaning up working directory.

# Making dir for storing intermediate files (can be deleted later)
mkdir -p "${OUTDIR}"/intermediate/

# # # Deleting unneccessary files
# rm "${OUTDIR}"/*filter.unique.precluster*fasta
rm "${OUTDIR}"/*.map
# rm "${OUTDIR}"/*filter.unique.precluster*count_table

# Moving all remaining intermediate files to the intermediate dir
mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/

# mv "${OUTDIR}"/current_files.summary ${LOGS}/current_saved_files.logfile

#####################################
# OTU ANALYSIS
#####################################
MOCKGROUPS="Mock1-Mock2-Mock3" # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS="Water1-Water2-Water3" # List of control groups in raw data dir separated by '-'
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'
LOGS="data/mothur/logs"


####################################
# Make Group-Specific Shared Files #
####################################

# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#
set.logfile(name=${LOGS}/sample_shared.logfile);
remove.groups(shared="${OUTDIR}"/final.shared, groups="${COMBINEDGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/sample.final.shared



# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#
set.logfile(name=${LOGS}/mock_shared.logfile);
get.groups(shared="${OUTDIR}"/final.shared, groups="${MOCKGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/mock.final.shared



# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#
set.logfile(name=${LOGS}/control_shared.logfile);
get.groups(shared="${OUTDIR}"/final.shared, groups="${CONTROLGROUPS}")"

# Renaming output file
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/control.final.shared