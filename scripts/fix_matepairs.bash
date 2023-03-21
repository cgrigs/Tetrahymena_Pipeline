#Step 2
#This script uses Samtool's fixmate
#fixmate is a tool that can fill in information (insert size, cigar, mapq) about paired end reads onto the corresponding other read


set -e

module load picard/2.9.2
PICARD_ARGS=FixMateInformation \
 MAX_RECORDS_IN_RAM=2000000 \
 VALIDATION_STRINGENCY=SILENT \
 ADD_MATE_CIGAR=True \
 ASSUME_SORTED=true 

# Input files
BAM_in="$1"
BAM_out="$2"

$PICARD $PICARD_ARGS I="$BAM_in" O="$BAM_out" 
