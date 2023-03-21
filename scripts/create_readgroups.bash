#Step 0
#This file will create a readgroups metadata file for use in alignment


awk '
  BEGIN { FS=OFS="\t"; ORS="\n" }
  NR == 1 { split($0,f); next }
  {
    for(i=1;i<=NF;i++) {
      printf "%s:%s%s", f[i], $i, (i<NF?OFS:ORS)
    }
  }
'

