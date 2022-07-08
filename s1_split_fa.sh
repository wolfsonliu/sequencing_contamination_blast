#! /usr/bin/bash
#$ -cwd
#$ -N blast_s1
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
DIR_FA=${DIR_WORK}/fa
# directory to store splited fa
DIR_SPLITFA=${DIR_WORK}/split_fa

cd ${DIR_WORK}

# idx starts with 1, but bash array starts with 0, using NA
LABs=(
    NA
    TEST
)

LAB=${LABs[$idx]}

echo $(date) "Start"

# 2000 lines and 1000 records each file
split -l 2000 --additional-suffix .fa ${DIR_FA}/${LAB}.fa ${DIR_SPLITFA}/${LAB}.fa.split.

# for FASTQ files
# cat ${DIR_BAM}/${LAB}.Unmapped.fq | \
#     paste - - - - | \
#     awk -F "\t" '{print "> " $1; print $2;}' | tr -d "@" | \
#     split -l 2000 --additional-suffix .fa - ${DIR_SPLITFA}/${LAB}.split.

echo $(date) "End"
