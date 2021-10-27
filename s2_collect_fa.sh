#! /usr/bin/bash
#$ -cwd
#$ -N blast_s2
#$ -o job.$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e job.$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -V
#$ -l h_rt=10:00:00
#$ -pe shared 2
#$ -t 1-1:1

THREAD=2

set -e -o pipefail

source $HOME/.bashrc

idx=$SGE_TASK_ID

# working directory
DIR_WORK=${HOME}/workdir
# directory to store BLAST databse
DIR_BLASTDB=${DIR_WORK}/blastdb
# directory to store fasta file of the sequenced data
DIR_FA=${DIR_WOKR}/fa
# directory to store splited fa
DIR_SPLITFA=${DIR_WOKR}/split_fa

cd ${DIR_WORK}

echo $(date) "Start"

ls ${DIR_SPLITFA} | \
    sed 's/^/${DIR_SPLITFA}\//g' \
        > ${DIR_WORK}/fafiles.txt

echo $(date) "End"
