#! /bin/bash
# make_contigs.sh

SAMPLEDIR="data/mothur/raw"
OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"
FILES="test.files"


###################
# Run QC Analysis #
###################

echo PROGRESS: Assembling and Screening unique representative sequences.

# Output dirs
mkdir -p "${OUTDIR}" "${LOGS}"

mothur "#set.logfile(name="${LOGS}"/make_contigs.logfile);
	make.contigs(file=test.files, inputdir="${SAMPLEDIR}", outputdir="${OUTDIR}");
	
	set.logfile(name="${LOGS}"/screen_unique.logfile);
	screen.seqs(fasta=current, group=current, maxambig=0, maxlength=275, maxhomop=8);
	unique.seqs(count=current);
	summary.seqs(fasta=current, count=current);"


# 	set.logfile(name=${LOGS}/seq_align_precluster.logfile);
# 	set.current(fasta=current);
#     align.seqs(fasta=current, reference=${SILVAALIGN});
#     screen.seqs(fasta=current, count=current, maxhomop=8);
#     filter.seqs(fasta=current, vertical=T, trump=.);
#     unique.seqs(fasta=current, count=current);
#     pre.cluster(fasta=current, count=current, diffs=2);


# 	set.logfile(name=${LOGS}/chimera_removal.logfile);
# 	set.current(fasta=current, count=current);
#     chimera.vsearch(fasta=current, count=current, dereplicate=T);
#     remove.seqs(fasta=current, accnos=current);


# 	set.logfile(name=${LOGS}/remove_lineage.logfile);
# 	set.current(fasta=current, count=current);
#    	classify.seqs(fasta=current, count=current, reference=${CLASSIFIER}, taxonomy=${TAXONOMY}, cutoff=80);
# 	remove.lineage(fasta=current, count=current, taxonomy=current, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota);
	
# 	set.logfile(name=${LOGS}/otu_clustering.logfile);
# 	set.current(fasta=current, count=current, taxonomy=current, list=current);
# 	dist.seqs(fasta=current, cutoff=0.03);
# 	cluster(column=current, count=current);
# 	make.shared(list=current, count=current, label=0.03);
# 	classify.otu(list=current, count=current, taxonomy=current, label=0.03);
# 	get.oturep(fasta=current, count=current, list=current, label=0.03, method=abundance);

# 	set.logfile(name=${LOGS}/lefse_n_biom.logfile);
# 	set.current(shared=current, constaxonomy=current);
# 	make.lefse(shared=current, constaxonomy=current);
# 	make.biom(shared=current, constaxonomy=current);"


# # Renaming output files for use later
# # mv ${OUTDIR}/*.precluster*pick.fasta ${ERRORDIR}/errorinput.fasta
# # mv ${OUTDIR}/*.vsearch*.pick.count_table ${ERRORDIR}"/errorinput.count_table
# mv "${OUTDIR}"/*.opti_mcc.list "${OUTDIR}"/final.list
# mv "${OUTDIR}"/*.opti_mcc.steps "${OUTDIR}"/final.steps
# mv "${OUTDIR}"/*.opti_mcc.sensspec "${OUTDIR}"/final.sensspec
# mv "${OUTDIR}"/*.opti_mcc.shared "${OUTDIR}"/final.shared
# mv "${OUTDIR}"/*.0.03.cons.taxonomy "${OUTDIR}"/final.taxonomy
# mv "${OUTDIR}"/*.0.03.cons.tax.summary "${OUTDIR}"/final.tax.summary
# mv "${OUTDIR}"/*.0.03.rep.fasta "${OUTDIR}"/final.rep.fasta
# mv "${OUTDIR}"/*.0.03.rep.count_table "${OUTDIR}"/final.rep.count_table
# mv "${OUTDIR}"/*.0.03.lefse "${OUTDIR}"/final.lefse
# mv "${OUTDIR}"/*.0.03.biom "${OUTDIR}"/final.biom


# ###############
# # Cleaning Up #
# ###############

# echo PROGRESS: Cleaning up working directory.

# # Making dir for storing intermediate files (can be deleted later)
# mkdir -p "${OUTDIR}"/intermediate/

# # # # Deleting unneccessary files
# # rm "${OUTDIR}"/*filter.unique.precluster*fasta
# rm "${OUTDIR}"/*.map
# # rm "${OUTDIR}"/*filter.unique.precluster*count_table

# # Moving all remaining intermediate files to the intermediate dir
# mv "${OUTDIR}"/test* "${OUTDIR}"/intermediate/

# mv "${OUTDIR}"/current_files.summary ${LOGS}/current_saved_files.logfile
