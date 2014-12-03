### This script will perform the Monte Carlo experiment described in the 'Spatial Dynamics of FMDV in South America' section of the main text
### The main idea was to study whether there were more transitions between neighbouring countries than not
## Data description: FROM and TO are pretty obvious, as are JUMPA and JUMPO (the mean number of transitions for each serotype)
## BORDER is an indicator variable that tells us if the two countries share borders 
## Finally, BFA and BFO are the Bayes factors from BSSVS computed with SPREAD
## These are the 56 transition rates that are common between the two serotypes (i.e. excluding Paraguay) 

### Copyleft (or the one to blame): Carvalho, LMF (2014)

mj <- data.frame(read.table("../DATA/BEAST_OUTPUT/MJ_56.csv", sep = ",",  head = TRUE))
#########
## Border vs Non-Border analysis
borderA <- mj$JUMPA[mj$BORDER==0]
NborderA <- mj$JUMPA[mj$BORDER==1]
borderO <- mj$JUMPO[mj$BORDER==0]
NborderO <- mj$JUMPO[mj$BORDER==1]

quantile(borderA, probs = c(.025, .5, .975))
quantile(NborderA, probs = c(.025, .5, .975))
quantile(borderO, probs = c(.025, .5, .975))
quantile(NborderO, probs = c(.025, .5, .975))

### Probabilistic assessment using Monte Carlo permutations
##  NOT RUN: Let's check the accuracy of the approach: simulate from reflected standard normals and see what Pr(B>NB)
# borderA <- abs(rnorm(length(borderA)))
# NborderA <- abs(rnorm(length(NborderA)))
# borderO <- abs(rnorm(length(borderO)))
# NborderO <- abs(rnorm(length(NborderO)))

simulate <- function(n){
  results <- data.frame(matrix(NA, n, 2))
  names(results) <- c("A", "O") 
  for (i in 1:n){
    cat("complete=", i/N*100, "%", "\n")
    bA <- sample(borderA, 1)
    bO <- sample(borderO, 1)
    nA <- sample(NborderA, 1)
    nO <- sample(NborderO, 1)
    results[i, 1] <- as.numeric(bA>nA)
    results[i, 2] <- as.numeric(bO>nO)  
  }
  return(results)
}
N <- 1e+04
colMeans(simulate(N))
# A      O 
# 0.4178 0.3547 