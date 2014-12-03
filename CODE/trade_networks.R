### This script will produce the plots presented in Figure S3 
### The idea here is to plot the trade networks using a threshold s to plot only (normalised) trade > s
### This may be useful for dense networks, as a way of clearing out noise
### see https://github.com/maxbiostat/papers/blob/master/PAPERS/proceedings/DINCON_2011_Carvalho%20et%20al.pdf for an idea of how that works out
### Copyleft (or the one to blame): Carvalho, LMF (2014)

source("aux/spatnet_aux.R")

library(maptools)
library(spdep)
library(RColorBrewer)

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
trade <- data.frame(read.table("../DATA//EPI_DATA/TRADE.txt", header = TRUE))
Mcattle <-matrix(trade$cattle, ncol = 9); colnames(Mcattle) <- rownames(Mcattle) <- Countries
Mpig <-matrix(trade$pig, ncol = 9); colnames(Mpig) <- rownames(Mpig) <- Countries
Msheep <-matrix(trade$sheep, ncol = 9); colnames(Msheep) <- rownames(Msheep) <- Countries

r <- c(0, .25)

for(s in seq(r[1], r[2], length.out = 5)){

pdf(paste("../FIGURES/PLOTS/tradenets_cattle_s=", s, ".pdf", sep = ""))  
plot.spatnet(SA, nmat = Mcattle, s = s, net = TRUE, dir = "to", brk = 5, mtitle = "Cattle", ltitle = " ")
dev.off()

pdf(paste("../FIGURES/PLOTS/tradenets_pig_s=", s, ".pdf", sep = ""))  
plot.spatnet(SA, nmat = Mpig, s = s, net = TRUE, dir = "to", brk = 5, mtitle = "Pigs", ltitle = " ")
dev.off()

pdf(paste("../FIGURES/PLOTS/tradenets_sheep_s=", s, ".pdf", sep = ""))  
plot.spatnet(SA, nmat = Msheep, s = s, net = TRUE, dir = "to", brk = 5, mtitle = "Sheep", ltitle = " ")
dev.off()

}
