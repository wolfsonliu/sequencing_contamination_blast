#! /usr/bin/bash
#$ -cwd
#$ -N blast_43
#$ -o job.$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e job.$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -V
#$ -l h_rt=50:00:00,highp
#$ -pe shared 2
#$ -t 1-1000:1

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

fa=$(awk -v idx=${idx} 'FNR == idx {print $1;}' ${DIR_WORK}/fafiles.txt)

echo $(date) "Start"
echo ${fa}

# All the aim taxonomy ids will be viewed as one taxonomy group, and
# the reads will be asigned the given group name. Otherwise the
# kingdom will be used for the reads.

python3 ${DIR_WORK}/scripts/get_main_group_blastn.py \
        "Homo sapiens" \
        9606,499232,499232,46359,9593,406788,9595,9597,9598,9601,9600,2051901 \
        ${fa}.blastn \
        ${fa}.blastn.maintaxgroup

echo $(date) "End"
