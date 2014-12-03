### This script will produce Figure 3 in the main text
### This are the results of the Bayesian Stochastic Search Variable Selection (BSSVS) and from-to (FT) migration inferred with Markov jumps robust counting 
### Copyleft (or the one to blame): Carvalho, LMF (2014)

source("aux//spatnet_aux.R")
data(wrld_simpl)
world <- wrld_simpl
Countries<-c("Argentina", "Bolivia", "Brazil", "Colombia", "Ecuador",
             "Paraguay", "Peru", "Uruguay", "Venezuela")

which.polys <- vector(mode = "list",length(Countries))

for (c in 1:length(Countries)){
  which.polys[[c]] <- grep(paste(Countries[c]), world$NAME)
}
SA <- world[unlist(which.polys), ]
################################
BFsA <- data.frame(read.table("../DATA//BEAST_OUTPUT//BFs_A.txt", header = TRUE))
BFsO <- data.frame(read.table("../DATA//BEAST_OUTPUT//BFs_O.txt", header = TRUE))

k <- length(Countries)
MA <- MO <- matrix(rep(0, k^2), ncol = k)
colnames(MA) <- rownames(MA) <- colnames(MO) <- rownames(MO) <- Countries

for(p in 1:nrow(BFsA)){ # creating a binary (incidence) matrix
  iA <- match(as.character(BFsA$FROM[p]), Countries)
  jA <- match(as.character(BFsA$TO[p]), Countries)
    MA[iA, jA] <- 1  
}

for(q in 1:nrow(BFsO)){
  iO <- match(as.character(BFsO$FROM[q]), Countries)
  jO <- match(as.character(BFsO$TO[q]), Countries)
    MO[iO, jO] <- 1  
}

FTA <- data.frame(read.table("../DATA//BEAST_OUTPUT//FT_A.txt", header = TRUE))
FTO <- data.frame(read.table("../DATA//BEAST_OUTPUT//FT_O.txt", header = TRUE))

fnbA <- mat2listw(MA, style = "B") # neighbourhood from the BF data
fnbO <- mat2listw(MO, style = "B") 

pdf("../FIGURES/MJandBFs.pdf")
par(mfrow = c(1, 2))
par(mai = c(0, 0, 0, 0))
plot.spatnett(SA, ws = BFsA$BF, nb = fnbA$neighbours, nets = FTA$FROM-FTA$TO, nbrk = 4,
              coropleth = TRUE, thck = TRUE, title = "Net migration rate")
legend( x = "top", legend = "A", cex = 1, bty = "n")
par(mai = c(0, 0, 0, 0))
plot.spatnettinv(SA, ws = BFsO$BF, nb = fnbO$neighbours, nets = FTO$FROM-FTO$TO, nbrk = 4, # don't even bother asking why a different plotting function...
              coropleth = TRUE, thck = TRUE, title = "Net migration rate")
legend( x = "top", legend = "O", cex = 1, bty = "n")
dev.off()
