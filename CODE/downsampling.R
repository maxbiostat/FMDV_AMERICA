### This script will perform the 'equal-downsampling' described in Text S2
### Copyleft (or the one to blame): Carvalho, LMF (2014)

library(ape) # needed to use read/write.dna
set.seed(8000) # reproducibility 

### Serotype A
bank_A <- read.dna("../DATA/SEQUENCES//A_131_sequences.fasta", format = "fasta")
country.A <- data.frame(read.table("../DATA//SEQUENCES/countries_A.txt"))
##
arg <- which(country.A=="Arg")
length(arg) # number of Argentinian sequences. There are 27 Venezuelan sequences.
s1 <- sample(arg, 27, replace = FALSE); ql1 <- c(s1, setdiff(1:131, arg))
s2 <- sample(arg, 27, replace = FALSE); ql2 <- c(s2, setdiff(1:131, arg))
s3 <- sample(arg, 27, replace = FALSE); ql3 <- c(s3, setdiff(1:131, arg))
s4 <- sample(arg, 27, replace = FALSE); ql4 <- c(s4, setdiff(1:131, arg))
s5 <- sample(arg, 27, replace = FALSE); ql5 <- c(s5, setdiff(1:131, arg))
#
write.dna(bank_A[ql1, ], "../DATA/SEQUENCES/A_subsample_1.fasta", format = "fasta")
write.dna(bank_A[ql2, ], "../DATA/SEQUENCES/A_subsample_2.fasta", format = "fasta")
write.dna(bank_A[ql3, ], "../DATA/SEQUENCES/A_subsample_3.fasta", format = "fasta")
write.dna(bank_A[ql4, ], "../DATA/SEQUENCES/A_subsample_4.fasta", format = "fasta")
write.dna(bank_A[ql5, ], "../DATA/SEQUENCES/A_subsample_5.fasta", format = "fasta")

### Serotype O
bank_O <- read.dna("../DATA//SEQUENCES//O_167_sequences.fasta", format = "fasta")
country.O <- data.frame(read.table("../DATA/SEQUENCES//countries_O.txt"))

ecu <- which(country.O=="Ecu")
length(ecu) #number of Ecuadorian sequences. There are 36 Colombian sequences.
s1 <- sample(ecu, 36, replace = FALSE); ql1 <- c(s1, setdiff(1:167, ecu))
s2 <- sample(ecu, 36, replace = FALSE); ql2 <- c(s2, setdiff(1:167, ecu))
s3 <- sample(ecu, 36, replace = FALSE); ql3 <- c(s3, setdiff(1:167, ecu))
s4 <- sample(ecu, 36, replace = FALSE); ql4 <- c(s4, setdiff(1:167, ecu))
s5 <- sample(ecu, 36, replace = FALSE); ql5 <- c(s5, setdiff(1:167, ecu))
#
write.dna(bank_O[ql1, ], "../DATA/SEQUENCES/O_subsample_1.fasta", format = "fasta")
write.dna(bank_O[ql2, ], "../DATA/SEQUENCES/O_subsample_2.fasta", format = "fasta")
write.dna(bank_O[ql3, ], "../DATA/SEQUENCES/O_subsample_3.fasta", format = "fasta")
write.dna(bank_O[ql4, ], "../DATA/SEQUENCES/O_subsample_4.fasta", format = "fasta")
write.dna(bank_O[ql5, ], "../DATA/SEQUENCES/O_subsample_5.fasta", format = "fasta")
