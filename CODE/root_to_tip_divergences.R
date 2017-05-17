## This script will take two maximum likelihood trees (one for each serotype) constructed with PhyML and plot the root-to-tip divergences
### Copyleft (or the one to blame): Carvalho, LMF (2017)
library(ggplot2)
rdv.A <- read.table("../DATA/SEQUENCES/RDV_serotype_A_VP1.txt", header = TRUE)
rdv.A$serotype <- "A"
rdv.O <- read.table("../DATA/SEQUENCES/RDV_serotype_O_VP1.txt", header = TRUE)
rdv.O$serotype <- "O"

A.lm <- lm(distance ~ date, data = rdv.A)
O.lm <- lm(distance ~ date, data = rdv.O)

forplot <- rbind(rdv.A, rdv.O)
number_ticks <- function(n) {function(limits) pretty(limits, n)}
pdf("../FIGURES/PLOTS/rdvs.pdf")
p <- qplot(date, distance, data = forplot, colour = serotype, fill = serotype) 
p +
  geom_point(size = 3)+
  stat_smooth(method = "lm", se = TRUE, fullrange = TRUE) +
  scale_x_continuous("Time (years)", breaks = number_ticks(10)) + 
  scale_y_continuous("Root-to-tip divergence", breaks = number_ticks(10)) +
  theme_bw() +
  annotate("text", x = 1960, y = .3,
           label = paste("A: R^2  == ", round(summary(A.lm)$r.squared, 3)), parse = TRUE) +
  annotate("text", x = 1960, y = .28,
           label = paste("O:R^2 == ", round(summary(O.lm)$r.squared, 3)), parse = TRUE)
dev.off()