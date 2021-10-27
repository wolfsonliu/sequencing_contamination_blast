#! /usr/bin/bash
#$ -cwd
#$ -N blast_s3
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

# 1. qseqid      query or source (e.g., gene) sequence id
# 2.  sseqid      subject  or target (e.g., reference genome) sequence id
# 3.  pident      percentage of identical matches
# 4.  length      alignment length (sequence overlap)
# 5.  mismatch    number of mismatches
# 6.  gapopen     number of gap openings
# 7.  qstart      start of alignment in query
# 8.  qend        end of alignment in query
# 9.  sstart      start of alignment in subject
# 10.  send        end of alignment in subject
# 11.  evalue      expect value
# 12.  bitscore

fa=$(awk -v idx=${idx} 'FNR == idx {print $1;}' ${DIR_WORK}/fafiles.txt)

echo $(date) "Start"
echo ${fa}

blastn -task megablast \
       -db nt \
       -evalue 1e-25 \
       -max_target_seqs 10 \
       -num_threads ${THREAD} \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore sscinames staxids sskingdoms" \
       -query ${fa} \
       -out ${fa}.blastn

echo $(date) "End"
