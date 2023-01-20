#! /bin/bash
# count_groups.sh

# Set the variables to be used in this script
FINALDIR="data/mothur/final" 
SHARED="sample.final.shared" # Shared file to be counted
# MOCKSHARED="mock.final.shared" # Shared file to be counted
# CONTROLSHARED="control.final.shared" # Shared file to be counted

LOGS="data/mothur/logs"

#########################
# Counting Shared Files #
#########################

# Generating read count tables for shared files
echo PROGRESS: Generating read count tables.

# Counting each shared file individually
mothur "#set.logfile(name=${LOGS}/count_groups.logfile);
    set.current(shared=${FINALDIR}/${SHARED});
    count.groups(shared=current, inputdir=${FINALDIR}, outputdir=${FINALDIR});"
    
    # set.current(shared=${FINALDIR}/${MOCKSHARED});
    # count.groups(shared=current, inputdir=${FINALDIR}, outputdir=${FINALDIR});
    
    # set.current(shared=${FINALDIR}/${CONTROLHARED});
    # count.groups(shared=current, inputdir=${FINALDIR}, outputdir=${FINALDIR})"