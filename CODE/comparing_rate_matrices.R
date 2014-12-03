### This script contains comparisons between rate matrices obtained for subsampled data sets, for both serotypes
### We will produce scatterplots and a heat map of L1-norms between subsamples
### These are presented in Figure S4
### Copyleft (or the one to blame): Carvalho, LMF (2014)

statesA <- c("Arg", "Bol", "Bra", "Col", "Ecu", "Per", "Uru", "Ven")
statesO <- c("Arg", "Bol", "Bra", "Col", "Ecu", "Par", "Per", "Uru", "Ven")

KA <- length(statesA)
nA <- KA^2
mA <- matrix(1:nA, ncol = KA)
posA <- mA[lower.tri(mA)]
gridA <- expand.grid(statesA, statesA)[posA, ]

KO <- length(statesO)
nO <- KO^2
mO <- matrix(1:nO, ncol = KO)
posO <- mO[lower.tri(mO)]  
gridO <- expand.grid(statesO, statesO)[posO, ]



matA <- read.csv("../DATA/BEAST_OUTPUT//matrices_downsampled_A.csv", header = TRUE, sep = "\t")
matO <- read.csv("../DATA/BEAST_OUTPUT//matrices_downsampled_O.csv", header = TRUE, sep = "\t")

# Colours to depict country of origin
library(RColorBrewer)
pal <-  brewer.pal(9, "Pastel1")
cols.A <- match(gridA$Var1, statesA)
cols.O <- match(gridO$Var1, statesO)

pdf("../FIGURES/PLOTS/rateplotA.pdf")
plot(matA, pch = 16, col = pal[cols.A])
title("Serotype A")
dev.off()
pdf("../FIGURES/PLOTS/rateplotO.pdf")
plot(matO, pch = 16, col = pal[cols.O])
title("Serotype O")
dev.off()

## Let's mount and log-transform the matrices

vec2mat <- function(v){ # vector to square matrix
  N <- length(v)
  K <- (1+sqrt(1+4*length(v)))/2
  M <- matrix(0, K, K)
  M[lower.tri(M)] <- v[1:(N/2)]
  M[upper.tri(M)] <- v[((N/2)+1):N]
  return(M)
}

mA1 <- log(vec2mat(matA[, 1])); diag(mA1) <- 0
mA2 <- log(vec2mat(matA[, 2])); diag(mA2) <- 0
mA3 <- log(vec2mat(matA[, 3])); diag(mA3) <- 0
mA4 <- log(vec2mat(matA[, 4])); diag(mA4) <- 0
mA5 <- log(vec2mat(matA[, 5])); diag(mA5) <- 0
mAl <- list(mA1, mA2, mA3, mA4, mA5)

mO1 <- log(vec2mat(matO[, 1])); diag(mO1) <- 0
mO2 <- log(vec2mat(matO[, 2])); diag(mO2) <- 0
mO3 <- log(vec2mat(matO[, 3])); diag(mO3) <- 0
mO4 <- log(vec2mat(matO[, 4])); diag(mO4) <- 0
mO5 <- log(vec2mat(matO[, 5])); diag(mO5) <-0
mOl <- list(mO1, mO2, mO3, mO4, mO5)


## Now the L1 and L2 norms of the log-transformed matrices

library(PET)

norm.comp <- function(ml, mode = "L1"){ # compute the norms
  ## Takes the list with the K matrices under comparison and the mode (norm, L1/L2)
  ## returns a K x K matrix with the norms (distances) for each pair
  K <- length(ml)
  M <- matrix(0, K, K)
  grid <- subset(expand.grid(1:K, 1:K), Var1!=Var2)
  for (p in 1:nrow(grid)){
    M[ grid[p, 1], grid[p, 2] ] <- PET::norm(ml[[grid[p, 1]]], ml[[grid[p, 2]]], mode = mode)    
  }
  return(M)
}

library(fields)
ats <- seq(0, 1, length.out = length(mAl))

pdf("../FIGURES/PLOTS/normplotA.pdf")
image.plot(norm.comp(mAl), main = "Serotype A", xaxt = "n", yaxt = "n")
image(norm.comp(mAl), main = "Serotype A", xaxt = "n", yaxt = "n", col = tim.colors(100), add = TRUE)
points(ats, ats, pch = "", xaxt = "n", yaxt = "n", xlab = "", ylab= "")
axis(1, at = ats, labels = paste("subsample", 1:5))
axis(2, at = ats, labels = paste("subsample", 1:5))
dev.off()

pdf("../FIGURES/PLOTS/normplotO.pdf")
image.plot(norm.comp(mOl), main = "Serotype O", xaxt = "n", yaxt = "n")
image(norm.comp(mOl), main = "Serotype A", xaxt = "n", yaxt = "n", col = tim.colors(100), add = TRUE)
points(ats, ats, pch = "", xaxt = "n", yaxt = "n", xlab = "", ylab= "")
axis(1, at = ats, labels = paste("subsample", 1:5))
axis(2, at = ats, labels = paste("subsample", 1:5))
dev.off()