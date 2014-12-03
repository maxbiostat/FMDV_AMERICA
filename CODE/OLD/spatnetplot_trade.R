### This script will produce the plots presented in Figure S3 
### Copyleft (or the one to blame): Carvalho, LMF (2014)

source("~spatnet_aux.R")
library(maptools);library(spdep);library(RColorBrewer)
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
trade <- data.frame(read.table("~/Dropbox/FMDV_AMERICA/DATA/TRADE_72.txt",TRUE))
trade <- subset(trade, FROM != TO)
M <- vec2sqmat(trade$pig); colnames(M) <- rownames(M) <- Countries
#FT <- data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/FT_A.txt",TRUE))
# par(mfrow = c(2, 2))
r <- c(0, .25)
for(s in seq(r[1], r[2], (r[2]-r[1])/5)){
plot.spatnet(SA, nmat = M, s = s, net = TRUE, dir = "to", brk = 5, mtitle = "Pigs", ltitle =" ")
}