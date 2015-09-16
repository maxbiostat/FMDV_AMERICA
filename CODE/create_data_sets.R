### This script will retrieve the sequences from Genbank after we figured out which ones we want
### Copyleft (or the one to blame): Carvalho, LMF (2015)

library(ape)
dataBaseA <- data.frame(read.csv("../DATA/SEQUENCES/vp1_serotype_A.csv", header = TRUE))
dataBaseO <- data.frame(read.csv("../DATA/SEQUENCES/vp1_serotype_O.csv", header = TRUE))  
rawA <- read.GenBank(dataBaseA$Accession.number)
rawO <- read.GenBank(dataBaseO$Accession.number)

createSeqName <- function(database, i){
  paste(database$Serotype[i], "_", i, "_", database$Accession.number[i],
        "_", database$Location[i], "_", database$Year[i], sep = "")
}
newNamesA <- sapply(1:nrow(dataBaseA), createSeqName, database = dataBaseA)
newNamesO <- sapply(1:nrow(dataBaseO), createSeqName, database = dataBaseO)

names(rawA) <- newNamesA
names(rawO) <- newNamesO

rawA
rawO

write.dna(rawA, file = "../DATA/SEQUENCES/serotype_A_unaligned.fasta", format = "fasta" )
write.dna(rawO, file = "../DATA/SEQUENCES/serotype_O_unaligned.fasta", format = "fasta" )