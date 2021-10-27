# Scripts for determining sequencing contamination with BLAST

Scripts for determining the contamination source in high-throughput
sequencing data with BLAST.

1. `s0_make_blastdb.sh`: download the nt database for BLAST
2. `s1_split_fa.sh`: split the FASTA files that derived from the raw
   FASTQ files for multiple processing
3. `s2_collect_fa.sh`: generate the file that contains all the split FASTA pathes.
4. `s3_blast.sh`: run blast on each split FASTA
