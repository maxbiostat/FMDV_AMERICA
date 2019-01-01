### This script will retrieve the sequences from Genbank after we figured out which ones we want
### Copyleft (or the one to blame): Carvalho, LMF (2017)
library(seqinr)
dataBaseA <- data.frame(read.csv("../DATA/SEQUENCES/data_acquisition/serotype_A_SA_metadata_final.csv",
                                 header = TRUE))
dataBaseO <- data.frame(read.csv("../DATA/SEQUENCES/data_acquisition/serotype_O_SA_metadata_final.csv",
                                 header = TRUE))  
raw <- read.fasta("../DATA/SEQUENCES/data_acquisition/VP1.fasta")

createSeqName <- function(database, i, serotype = "A"){
  paste(serotype, "_", sprintf("%03d", i), "_", database$accession[i],
        "_", database$country[i], "_", database$date[i], sep = "")
}
newNamesA <- sapply(1:nrow(dataBaseA), createSeqName, database = dataBaseA)
newNamesO <- sapply(1:nrow(dataBaseO), createSeqName, database = dataBaseO, serotype = "O")

posA <- sapply(dataBaseA$accession, function(x) grep(x, names(raw)))
posO <- sapply(dataBaseO$accession, function(x) grep(x, names(raw)))

## asserting
length(unique(posA)) == nrow(dataBaseA)
length(unique(posO)) == nrow(dataBaseO)

orderedA <- raw[posA]
orderedO <- raw[posO] 

write.fasta(orderedA, names = newNamesA, file = "../DATA/SEQUENCES/serotype_A_VP1_renamed_unaligned.fasta")
write.fasta(orderedO, names = newNamesO, file = "../DATA/SEQUENCES/serotype_O_VP1_renamed_unaligned.fasta")
