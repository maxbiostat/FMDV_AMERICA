### This script will produce the plots presented in Figure 
### Copyleft (or the one to blame): Carvalho, LMF (2014)
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
Mcattle <- matrix(trade$cattle, ncol = 9); colnames(Mcattle) <- rownames(Mcattle) <- Countries
Mpig <- matrix(trade$pig, ncol = 9); colnames(Mpig) <- rownames(Mpig) <- Countries
Msheep <- matrix(trade$sheep, ncol = 9); colnames(Msheep) <- rownames(Msheep) <- Countries
#
coordsSA <- coordinates(SA)
library(fields)
distmat <- rdist.earth(coordsSA, miles = FALSE)

fcattle <- as.vector(Mcattle)
fsheep <- as.vector(Msheep)
fpigs <- as.vector(Mpig)
flux <- c(fcattle, fsheep, fpigs)
livestock <- c(rep("Cattle", length(Countries)^2),
               rep("Sheep", length(Countries)^2),
               rep("Swine", length(Countries)^2))
forplot <- data.frame(distance = as.vector(distmat),
                      flux = flux,
                      livestock = livestock)

forplot <- subset(forplot, flux >0)
library(ggplot2)
p <- qplot(distance, log(flux), data = forplot, colour = livestock) 
pdf("../FIGURES/PLOTS/distance_vs_flux.pdf")
p +
  geom_point(size = 3) +
  scale_y_continuous("Log of number of animals exchanged") + 
  scale_x_continuous("Geodesic distance")
dev.off()