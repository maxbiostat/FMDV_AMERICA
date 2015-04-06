## This script will take two maximum likelihood trees (one for each serotype) constructed with PhyML and plot the root-to-tip divergences
### Copyleft (or the one to blame): Carvalho, LMF (2015)
library(devtools)
source_url("https://raw.githubusercontent.com/maxbiostat/CODE/master/R/PHYLO/find_best_rooting.R")
library(ape)
mltree.A <- read.tree("../DATA/SEQUENCES/serotype_A_ML_tree_GTR_G.newick")
mltree.O <- read.tree("../DATA/SEQUENCES/serotype_O_ML_tree_GTR_G.newick")

brootingA <- find_best_rooting(tree = mltree.A)
brootingO <- find_best_rooting(tree = mltree.O)

brootingA$table$serotype <- rep("A", nrow(brootingA$table))
brootingO$table$serotype <- rep("O", nrow(brootingO$table))

forplot <- rbind(brootingA$table, brootingO$table)

library(ggplot2)
p <- qplot(dates, rdv, data = forplot, colour = serotype) 
pdf("../FIGURES/PLOTS/rdvs.pdf")
p +
  geom_point(size = 3) +
  stat_smooth(method = "lm", se = TRUE) +
  scale_x_continuous("Time (years)") + 
  scale_y_continuous("Root-to-tip divergence") +
  theme_bw() +
  annotate("text", x = 1960, y = .3,
           label = paste("A: R^2  == ", round(summary(brootingA$lm)$r.squared, 3)), parse = TRUE) +
  annotate("text", x = 1960, y = .28,
           label = paste("O:R^2 == ", round(summary(brootingO$lm)$r.squared, 3)), parse = TRUE)
dev.off()
