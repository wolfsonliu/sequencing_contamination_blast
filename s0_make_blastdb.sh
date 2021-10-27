#! /usr/bin/bash
#$ -cwd
#$ -N blast_s0
#$ -o job.$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e job.$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -V
#$ -l h_rt=20:00:00
#$ -pe shared 1
#$ -t 1-1:1

set -e -o pipefail

source ${HOME}/.bashrc

# working directory
DIR_WORK=${HOME}/workdir
# directory to store BLAST databse
DIR_BLASTDB=${DIR_WORK}/blastdb

mkdir -p ${DIR_BLASTDB}
cd ${DIR_BLASTDB}

echo $(date) "Start"

if [ ! -e ${HOME}/.ncbirc ]; then
    echo "[BLAST]" > ${HOME}/.ncbirc
    echo "BLASTDB=${HOME}/workdir/blastdb" >> ${HOME}/.ncbirc
    update_blastdb.pl --passive --decompress nt
fi

echo $(date) "End"
