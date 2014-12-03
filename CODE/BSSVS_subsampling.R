### This script will produce the plots presented in Figures S4 & S5 in Text S2
### This are the results of the Bayesian Stochastic Search Variable Selection (BSSVS) for each of the five sub-samples 
### Copyleft (or the one to blame): Carvalho, LMF (2014)

source("aux/spatnet_aux.R")
data(wrld_simpl)
world <- wrld_simpl
Countries <- c("Argentina", "Bolivia", "Brazil", "Colombia", "Ecuador",
             "Paraguay", "Peru", "Uruguay", "Venezuela")

which.polys <- vector(mode = "list", length(Countries))
for (c in 1:length(Countries)){
  which.polys[[c]] <- grep(paste(Countries[c]), world$NAME)
}
SA <- world[unlist(which.polys), ]
################################
for (s in 1:5){  
  BFs <- data.frame(read.table(paste("../DATA/BEAST_OUTPUT//SSA", s, ".csv", sep = ""), header = TRUE, sep = ";"))
  k <- length(Countries)
  M <- matrix(rep(0, k^2), ncol = k)
  colnames(M)<- rownames(M) <- Countries
  for(p in 1:nrow(BFs)){ # creating a binary (incidence) matrix
    i <- pmatch(as.character(BFs$FROM[p]), Countries)
    j <- pmatch(as.character(BFs$TO[p]), Countries)
    M[i, j] <- 1  
  }
  ProotA <- data.frame(read.table("../DATA//BEAST_OUTPUT//Proot_SSA.csv", header = TRUE))
  fnb <- mat2listw(M, style = "B")
  pdf(file = paste("../FIGURES/PLOTS//A_ss", s, ".pdf", sep = ""))
  plot.spatnett(SA, ws = BFs$BF, nb = fnb$neighbours, nets = ProotA[, s+1], 
                nbrk = 4, coropleth = TRUE, thck = TRUE, title = "Pr(root)")  
  dev.off()
}
for (s in 1:5){  
  BFs <- data.frame(read.table(paste("../DATA//BEAST_OUTPUT//SSO", s, ".csv", sep = ""), header = TRUE, sep = ";"))
  k <- length(Countries)
  M <- matrix(rep(0, k^2), ncol = k)
  colnames(M) <- rownames(M) <- Countries
  for(p in 1:nrow(BFs)){
    i <- pmatch(as.character(BFs$FROM[p]), Countries)
    j <- pmatch(as.character(BFs$TO[p]), Countries)
    M[i, j] <- 1  
  }
  ProotO <- data.frame(read.table("../DATA//BEAST_OUTPUT//Proot_SSO.csv", header = TRUE))
  fnb <- mat2listw(M, style = "B")
  pdf(file = paste("../FIGURES/PLOTS//O_ss", s, ".pdf", sep = ""))
  plot.spatnett(SA, ws = BFs$BF, nb = fnb$neighbours, nets = ProotO[, s+1], 
                nbrk = 4, coropleth = TRUE, thck = TRUE, title = "Pr(root)")  
  dev.off()
}