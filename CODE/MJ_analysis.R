### This script will compare the numbers and proportions of "border" vs "non-border" transitions, summarised using robust counting, for both serotypes
### Copyleft (or the one to blame): Carvalho, LMF (2014)

A.total <- data.frame(read.table("../DATA/BEAST_OUTPUT/A_total_transitions.txt", header = TRUE))[, 2]
A.b <- data.frame(read.table("../DATA/BEAST_OUTPUT/A_border.txt", header = TRUE))[, 2]
A.nb <- data.frame(read.table("../DATA/BEAST_OUTPUT/A_non_border.txt", header = TRUE))[, 2]

burninA <- round(length(A.total)*.3)
whichA <- burninA:length(A.total)

p.nborderA <- A.nb[whichA]/A.total[whichA]
quantile(p.nborderA, probs = c(.025, .5, .975))

######################

O.total <- data.frame(read.table("../DATA/BEAST_OUTPUT/O_total_transitions.txt", header = TRUE))[, 2]
O.b <- data.frame(read.table("../DATA/BEAST_OUTPUT/O_border.txt", header = TRUE))[, 2]
O.nb <- data.frame(read.table("../DATA/BEAST_OUTPUT/O_non_border.txt", header = TRUE))[, 2]

burninO <- round(length(O.total)*.3)
whichO <- burninO:length(O.total)

p.nborderO <- O.nb[whichO]/O.total[whichO]
quantile(p.nborderO, probs = c(.025, .5, .975))

pdf("../FIGURES/PLOTS/non_border_proportions.pdf")
hist(p.nborderA, breaks = 15, col = 2, main = "Proportion of non-border transitions", xlab = expression(p))
hist(p.nborderO , breaks = 15, col = 3, add = TRUE)
dev.off()
