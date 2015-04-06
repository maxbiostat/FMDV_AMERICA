### This script will create the normalised predictors for the analyses presented in Table 2
### If you want the predictors for serotype O, use K = 9, if you want them for serotype A, use K = 8. 
### Copyleft (or the one to blame): Carvalho, LMF (2014)

trade <- data.frame(read.table("../DATA/EPI_DATA/TRADE.txt", header = TRUE))

# Cattle
Mcattle <- matrix(trade$cattle, ncol = 9)
Mcattle <- abs(scale(Mcattle + 1, center = FALSE)); diag(Mcattle) <- 0 # Just to be sure

u <- upper.tri(Mcattle, diag = FALSE)
l <- lower.tri(Mcattle, diag = FALSE)

pwcattle <- c(Mcattle[l], Mcattle[u])

# Pigs
Mpig <- matrix(trade$pig, ncol = 9) ; diag(Mpig) <- 0
Mpig <- abs(scale(Mpig + 1, center = FALSE))
pwpig <- c(Mpig[l], Mpig[u])

# Sheep 
Msheep <- matrix(trade$sheep, ncol = 9); diag(Msheep) <- 0
Msheep <- abs(scale(Msheep + 1, center = FALSE))
pwsheep <- c(Msheep[l], Msheep[u])

## Let's take a look

pdf("../FIGURES/PLOTS/tradepriors.pdf")
plot(density(pwcattle), lwd = 2, xlab = expression(m[jk]), main = "")
lines(density(pwpig), lwd = 2, col = 2)
lines(density(pwsheep), lwd = 2, col = 3)
legend(x = "top", legend = c("Cattle", "Pigs", "Sheep"), col = 1:3, lwd = rep(2, 3), bty = "n")
dev.off()

# Exporting 
# This will export .txt files that can be easily copy/pasted into XML blocks for BEAST
K <- 9
nk <- K*(K-1)
if(K==8){
  filt1 <- data.frame(subset(trade, FROM!=TO), ind = 1:72)
  nonpar.pos <- subset(subset(filt1, FROM!="Paraguay"), TO!="Paraguay")$ind # the positions excluding Paraguay (which is absent for serotype A)
  pwcattle <- pwcattle[nonpar.pos]
  pwpig <- pwpig[nonpar.pos]
  pwsheep <- pwsheep[nonpar.pos]    
}
write.table(data.frame(matrix(signif(pwcattle, 3), ncol = nk)), 
            file = paste("../DATA/EPI_DATA/cattle_pred_", nk, ".txt", sep=""), sep = " ", col.names = FALSE, row.names = FALSE)

write.table(data.frame(matrix(signif(pwpig, 3), ncol = nk)), 
            file = paste("../DATA/EPI_DATA/pig_pred_", nk, ".txt", sep=""), sep = " ", col.names = FALSE, row.names = FALSE)

write.table(data.frame(matrix(signif(pwsheep, 3), ncol = nk)), 
            file = paste("../DATA/EPI_DATA/sheep_pred_", nk, ".txt", sep=""), sep = " ", col.names = FALSE, row.names = FALSE)
