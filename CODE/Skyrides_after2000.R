### As described in the main text, our samlping is quite sparse prior to the 1990's
### So what we did was to estimate skyrides from sequences with sampling date > 2000 only
### This script will plot the results of these analyses, presented in Figure S6
### Copyleft (or the one to blame): Carvalho, LMF (2014)

skyA <- data.frame(read.table("../DATA/BEAST_OUTPUT/skyride_Afrom2000.txt", header = TRUE, sep = "\t"))
skyO <- data.frame(read.table("../DATA/BEAST_OUTPUT/skyride_Ofrom2000.txt", header = TRUE, sep = "\t"))

cases <- data.frame(read.table("../DATA/EPI_DATA//cases_FMD.txt", header = TRUE, sep = "\t"))
vac <- data.frame(read.table("../DATA//EPI_DATA//vac_FMD.txt", header = TRUE, sep = "\t"))

cases$A <- log(cases$A + 1)
cases$O <- log(cases$O + 1)

skyA[, 2:5] <- apply(skyA[, 2:5], 2, log)
skyO[, 2:5] <- apply(skyO[, 2:5], 2, log)

# Serotype A
pdf("../FIGURES/PLOTS/SFig_A2000sky.pdf")
plot(skyA$Time, skyA$Mean, ylim = c(0, 10), lwd = 2, ylab = "Effective Population Size",
     xlab = "Time (years)", col = "blue", type = "l", xlim = c(1990, 2008))
polygon(c(skyA$Time, rev(skyA$Time)), c(skyA$Lower, rev(skyA$Upper)), col = "red", border = "red")
lines(skyA$Time, skyA$Mean, lwd = 2, ylab = "Effective Population Size", xlab = "Time", col = 1)
lines(cases$YEAR, cases$A, lwd = 2, type = "b", col = "green")
par(new = TRUE) 
plot(vac$Year, vac$Mean, lwd = 2, type = "b", pch = 23, ann = FALSE, xaxt = "n", yaxt = "n", ylab = "", col = "blue")
axis(4) 
legend(x = "topleft", bty = "n", lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "green", "blue"),
       legend = c("Viral Populations", "FMD Cases", "Vaccine Doses per head"), cex = 1)
dev.off()

## Serotype O
pdf("../FIGURES/PLOTS/SFig_O2000sky.pdf")
plot(skyO$Time, skyO$Mean, ylim = c(0, 10), lwd = 2, ylab = "Effective Population Size",
     xlab = "Time (years)", col = "blue", type = "l", xlim = c(1993, 2008))
polygon(c(skyO$Time, rev(skyO$Time)), c(skyO$Lower, rev(skyO$Upper)), col = "skyblue", border = "black")
lines(skyO$Time, skyO$Mean, lwd = 2, ylab = "Effective Population Size", xlab = "Time", col = 1)
lines(cases$YEAR, cases$O, lwd = 2, type = "b", col = "green")
par(new = TRUE) 
plot(vac$Year, vac$Mean, lwd = 2, type = "b", pch = 23, ann = FALSE, xaxt = "n", yaxt = "n", ylab = "", col = "blue")
axis(4) 
legend(x = "topleft", bty = "n", lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "green", "blue"),
       legend = c("Viral Populations", "FMD Cases", "Vaccine Doses per head"), cex = 1)
dev.off()