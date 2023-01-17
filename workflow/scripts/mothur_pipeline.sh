#! /bin/bash
# mothur_pipeline.sh

# Set the variables to be used in this script
SAMPLEDIR="data/mothur/raw"
SILVAALIGN="data/mothur/references/silva.v4.align"
CLASSIFIER="data/mothur/references/trainset16_022016.pds.fasta"
TAXONOMY="data/mothur/references/trainset16_022016.pds.tax"

OUTDIR="data/mothur/process"
ERRORDIR="data/mothur/process/error_analysis"
LOGS="data/mothur/logs"

###########################################################################
# Reference files #
###########################################################################

# Directory for storing reference files
REFSDIR="data/mothur/references"
LOGS="data/mothur/logs"

echo PROGRESS: Preparing mothur reference files. 

# Making reference output directory
mkdir -p ${REFSDIR}/ ${REFSDIR}/tmp/ "${LOGS}"

echo PROGRESS: Preparing mothur-based SILVA sequence alignments. 
echo For more inforamtion see https://mothur.org/wiki/silva_reference_files/

curl -L -R -o ${REFSDIR}/tmp/silva.seed_v138.tgz -z ${REFSDIR}/tmp/silva.seed_v138.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138.tgz

# Decompressing the database
tar -xvzf ${REFSDIR}/tmp/silva.seed_v138.tgz -C ${REFSDIR}/tmp/

# Using mothur to pull out bacterial sequences and only keep sequences from the v4 region of the 16S rRNA DNA region
mothur "#set.logfile(name=${LOGS}/get_ref_alignment.logfile);
	get.lineage(fasta=${REFSDIR}/tmp/silva.seed_v138.align, taxonomy=${REFSDIR}/tmp/silva.seed_v138.tax, taxon=Bacteria);
	pcr.seqs(fasta=current, start=11894, end=25319, keepdots=F, processors=8)"



# Renaming the final output files
mv ${REFSDIR}/tmp/silva.seed_v138.pick.align ${REFSDIR}/silva.seed.align
mv ${REFSDIR}/tmp/silva.seed_v138.pick.tax ${REFSDIR}/silva.seed.tax
mv ${REFSDIR}/tmp/silva.seed_v138.pick.pcr.align ${REFSDIR}/silva.v4.align

# Cleaning up reference dir
rm -rf "${REFSDIR}"/tmp/

mothur "#set.logfile(name=${LOGS}/degap_silva_align.logfile);
	degap.seqs(fasta=${REFSDIR}/silva.seed.align)"



echo PROGRESS: Preparing Mothur-based RPD taxonomy files.

# Making reference output directory
mkdir -p "${REFSDIR}"/ "${REFSDIR}"/tmp/


# For more information see https://mothur.org/wiki/rdp_reference_files/
curl -L -R -o "${REFSDIR}"/tmp/trainset16_022016.pds.tgz -z "${REFSDIR}"/tmp/trainset16_022016.pds.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset16_022016.pds.tgz

# Decompressing the database
tar -xvzf "${REFSDIR}"/tmp/trainset16_022016.pds.tgz -C "${REFSDIR}"/tmp/

# Move the taxonomy files out of the tmp dir
mv "${REFSDIR}"/tmp/trainset16_022016.pds/trainset16_022016* "${REFSDIR}"/

# Cleaning up reference dir
rm -rf "${REFSDIR}"/tmp/


echo PROGRESS: Preparing Mothur-based ZYMO Mock.
# Downloading sequence files for mock community members
curl -L -R -o "${REFSDIR}"/tmp/ZymoBIOMICS.STD.refseq.v2.zip -z "${REFSDIR}"/tmp/ZymoBIOMICS.STD.refseq.v2.zip https://s3.amazonaws.com/zymo-files/BioPool/ZymoBIOMICS.STD.refseq.v2.zip

# Decompressing
unzip -o "${REFSDIR}"/tmp/ZymoBIOMICS.STD.refseq.v2.zip -d "${REFSDIR}"/tmp/

# Overwriting the current mock sequence file if one already exists, creates the file if it doesn't exist
echo -n "" > "${REFSDIR}"/zymo.mock.16S.fasta

# Concatenating all of the sequence files into a single reference file
for FASTA in "${REFSDIR}"/tmp/ZymoBIOMICS.STD.refseq.v2/ssrRNAs/*; do

	cat "${FASTA}" >> "${REFSDIR}"/zymo.mock.16S.fasta

done

# Copying data files to tmp dir for v4 alignment
cp "${REFSDIR}"/silva.seed.align "${REFSDIR}"/zymo.mock.16S.fasta "${REFSDIR}"/tmp/

# Aligning mock sequences to the SILVA v4 region
# Will generate the following warning message '[WARNING]: 4 of your sequences generated alignments that eliminated too many bases' 
# because 4 of the community sequences are from Cryptococcus and Saccharomyces so those will be filtered out
mothur "#align.seqs(fasta="${REFSDIR}"/tmp/zymo.mock.16S.fasta, reference="${REFSDIR}"/tmp/silva.seed.align, processors=8);
	pcr.seqs(fasta="${REFSDIR}"/tmp/zymo.mock.16S.align, start=11894, end=25319, keepdots=F);
	degap.seqs(fasta="${REFSDIR}"/tmp/zymo.mock.16S.pcr.align)"

# Sorting the output file by the first field (read name) and second letter (ignores the '>' at the read header and will sort on the second letter instead)
# Not super important but it makes it more human friendly
awk '{ORS=NR%2?",":"\n";print}' "${REFSDIR}"/tmp/zymo.mock.16S.pcr.ng.fasta | sort -k 1.2 | tr , '\n' > "${REFSDIR}"/zymo.mock.16S.v4.fasta

# Cleaning up
rm -rf "${REFSDIR}"/tmp/


###########################################################################
# Mothur Analysis #
###########################################################################

echo PROGRESS: Assembling, quality controlling, clustering, and classifying sequences.

# Making output dir
mkdir -p "${OUTDIR}" "${LOGS}" "${ERRORDIR}" 

mothur "#set.logfile(name=${LOGS}/sample_files.logfile);
	set.dir(input=${SAMPLEDIR}, output=${OUTDIR});
	
	make.file(type=fastq, prefix=test, inputdir=${SAMPLEDIR}, outputdir=${OUTDIR});
	
	set.logfile(name=${LOGS}/seq_assembly.logfile);
	set.current(file=current);
	make.contigs(file=current);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);


	set.logfile(name=${LOGS}/seq_align_precluster.logfile);
	set.current(fasta=current);
    align.seqs(fasta=current, reference=${SILVAALIGN});
    screen.seqs(fasta=current, count=current, maxhomop=8);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=2);


	set.logfile(name=${LOGS}/chimera_removal.logfile);
	set.current(fasta=current, count=current);
    chimera.vsearch(fasta=current, count=current, dereplicate=T);
    remove.seqs(fasta=current, accnos=current);


	set.logfile(name=${LOGS}/remove_lineage.logfile);
	set.current(fasta=current, count=current);
   	classify.seqs(fasta=current, count=current, reference=${CLASSIFIER}, taxonomy=${TAXONOMY}, cutoff=80);
	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
	
	set.logfile(name=${LOGS}/otu_clustering.logfile);
	set.current(fasta=current, count=current, taxonomy=current, list=current);
	dist.seqs(fasta=current, cutoff=0.03);
	cluster(column=current, count=current);
	make.shared(list=current, count=current, label=0.03);
	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
	set.current(shared=current, constaxonomy=current);
	make.lefse(shared=current, constaxonomy=current);
	make.biom(shared=current, constaxonomy=current);"


echo PROGRESS: Formating file for downstream analysis

mkdir -p "${OUTDIR}"  "${LOGS}" 

mothur "#set.logfile(name=${LOGS}/format_files.logfile);"
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


###############
# Splitting Otutable #
###############

MOCKGROUPS="Mock1-Mock2-Mock3" # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS="Water1-Water2-Water3" # List of control groups in raw data dir separated by '-'
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'


# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#set.logfile(name=${LOGS}/split_otutable.logfile);
remove.groups(shared="${OUTDIR}"/final.shared, groups="${COMBINEDGROUPS}")"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/sample.final.shared


# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/final.shared, groups="${MOCKGROUPS}")"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/mock.final.shared

# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/final.shared, groups="${CONTROLGROUPS}")"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/control.final.shared