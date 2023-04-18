#/usr/bin/Rscript --vanilla

# CASAVA 1.8
# Illumina FASTQ files use the following naming scheme:
# <sample name>_<barcode sequence>_L<lane (0-padded to 3 digits)>_R<read number>_<set number (0-padded to 3 digits>.fastq.gz
#
# Each sequence identifier, the line that precedes the sequence and describes it, needs to be in the following format:
# @<instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<x-pos>:<y-pos> <read>:<is filtered>:<control number>:<index sequence>

isodate = "2017-04-14"
seqcenter = "DNASU"
model = "NextSeq"
description = "\"T. thermophila Whole Genome DNA\""

options(stringsAsFactors=FALSE)

suppressPackageStartupMessages(library(stringr)) #biocondcutor

main = function(filename) {
    
    line = readLines(filename, n=1)
    a = str_split(line,"[: ]")[[1]]
    flowcell = a[3]
    lane = a[4]
    index = a[11] # assumes multiplexing

    rg_id = paste(flowcell, lane, index, sep=".")
    rg_pu = paste(flowcell, lane, sep=".")
    rg_pl = "ILLUMINA"
    rg_lb = str_extract(basename(filename), "^\\w+(?=_S\\d+_L\\d\\d\\d)")
    rg_sm = str_match(rg_lb, "^(\\w+?)(_\\d+)?$")[2]

	base = str_extract(basename(filename), "^\\w+_S\\d+_L\\d\\d\\d(?=_R[12])")

    list(file = filename, base = base, ID = rg_id, LB=rg_lb, SM = rg_sm, PU = rg_pu, PL = rg_pl,
        DT = isodate, CN = seqcenter, PM = model, DS = description)
}

if(!interactive()) {
    ARGS = commandArgs(trailingOnly=TRUE)
    res = lapply(ARGS, main)
    out = do.call(rbind.data.frame, res)
    write.table(out, sep="\t", quote=FALSE, row.names=FALSE)
}
