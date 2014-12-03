### This script will produce the plot presented in Figure S1
### Copyleft (or the one to blame): Carvalho, LMF (2014)

hsizes <- data.frame(read.table("../DATA//EPI_DATA/herd_sizes.csv", header = TRUE))

pdf("../FIGURES/PLOTS/production.pdf")
plot(hsizes$year, log(hsizes$cattle), type = "b", pch = 20,  col = "blue", lwd = 2, main = "Livestock production",
     ylab = "log(herd size)", xlab = "Time (years)", ylim = c(17, 20))
lines(hsizes$year, log(hsizes$pigs), type = "b", pch = 20, lwd = 2, col = 2)
lines(hsizes$year, log(hsizes$sheep), type = "b", pch = 20,  lwd = 2, col = 3)
legend(x = "topleft", legend = c("Cattle", "Pigs", "Sheep"), col = c("blue", "red", "green"), bty = "n", pch = 20, lwd = 2)
dev.off()