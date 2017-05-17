### This script will retrieve the sequences from Genbank after we figured out which ones we want
### Copyleft (or the one to blame): Carvalho, LMF (2017)
library(seqinr)
dataBaseA <- data.frame(read.csv("../DATA/SEQUENCES/data_aquisition/serotype_A_SA_metadata_final.csv", header = TRUE))
dataBaseO <- data.frame(read.csv("../DATA/SEQUENCES/data_aquisition/serotype_O_SA_metadata_final.csv", header = TRUE))  
rawA <- read.fasta("../DATA/SEQUENCES/data_aquisition/SA_serotype_A_VP1_alignment.fasta")
rawO <- read.fasta("../DATA/SEQUENCES/data_aquisition/SA_serotype_O_VP1_alignment.fasta")

createSeqName <- function(database, i, serotype = "A"){
  paste(serotype, "_", sprintf("%03d", i), "_", database$accession[i],
        "_", database$country[i], "_", database$date[i], sep = "")
}
newNamesA <- sapply(1:nrow(dataBaseA), createSeqName, database = dataBaseA)
newNamesO <- sapply(1:nrow(dataBaseO), createSeqName, database = dataBaseO, serotype = "O")

posA <- sapply(dataBaseA$accession, function(x) grep(x, names(rawA)))
posO <- sapply(dataBaseO$accession, function(x) grep(x, names(rawO)))
orderedA <- rawA[posA]
orderedO <- rawO[posO] 

write.fasta(orderedA, names = newNamesA, file = "../DATA/SEQUENCES/serotype_A_VP1_renamed.fasta")
write.fasta(orderedO, names = newNamesO, file = "../DATA/SEQUENCES/serotype_O_VP1_renamed.fasta")