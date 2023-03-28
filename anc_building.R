#/usr/bin/Rscript --vanilla

# CASAVA 1.8
# Illumina FASTQ files use the following naming scheme:
# <sample name>_<barcode sequence>_L<lane (0-padded to 3 digits)>_R<read number>_<set number (0-padded to 3 digits>.fastq.gz
#
# Each sequence identifier, the line that precedes the sequence and describes it, needs to be in the following format:
# @<instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<x-pos>:<y-pos> <read>:<is filtered>:<control number>:<index sequence>


# Install package from CRAN only if not installed, and load the library
if (!require(testthat)) install.packages('testthat')
library(testthat)

# the run date of the sequencing
isodate = "2016-01-19"
seqcenter = "DNASU"
model = "NextSeq"
description = "\"T. thermophila Whole Genome DNA\""

options(stringsAsFactors=FALSE)

suppressPackageStartupMessages(library(stringr))

main = function(filename) {
  # read the first line from the fastq file
  line = readLines(filename, n=400)
  # split sequencing identifier
  a = str_split(line[1],"[: ]")[[1]]
  flowcell = a[3]
  lane = a[4]
  
  index = c()
  for(i in seq(1,400,4)) {
    a = str_split(line[i],"[: ]")[[1]]
    index = c(index, a[11]) # assumes multiplexing
  }
  
  index = names(rev(sort(table(index))))[1]
  
  rg_id = paste(flowcell, lane, index, sep=".")
  rg_pu = paste(flowcell, lane, sep=".")
  rg_pl = "ILLUMINA"
  rg_lb = str_extract(basename(filename), "^[-\\w]+(?=_S\\d+_L\\d\\d\\d)")
  rg_sm = str_match(rg_lb, "^([-\\w]+?)(-[AB]+)?$")[2]
  
  base = str_extract(basename(filename), "^[-\\w]+_S\\d+_L\\d\\d\\d(?=_R[12])")
  
  dt = isodate
  pm = model
  if(base == "Anc-1-B_S1_L001") {
    dt = "2016-02-10"
    pm = "MiSeq"
  }
  
  final_list  =list(file = filename, base = base, ID = rg_id,
                    LB=rg_lb, SM = rg_sm, PU = rg_pu, PL = rg_pl,
                    DT = dt, CN = seqcenter, PM = pm, DS = description)
}

if(!interactive()) {
  ARGS = commandArgs(trailingOnly=TRUE)
  res = lapply(ARGS, main)
  out = do.call(rbind.data.frame, res)
  write.table(out, sep="\t", quote=FALSE, row.names=FALSE)
}






# A unit test to check if description is a numeric value
test_that("description is numeric", {
  
  # Test that description is numeric
  expect_is_numeric(description)
  
})





# A unit test to check if the type is a list
test_that("object is a list", {
  
  # Test that the list is a list
  expect_true(is.list(final_list))
  
})
