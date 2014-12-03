### This script will produce the plots presented in Figure 4 in the main text
### We will summarise and plot the results of the "Epidemic tracing" analysis 
### This script modifies R code by Matthew Hall (IEB, Edinburgh) to analysed the output of BEAST tools "BranchJumpPlotter.java" and
### "TaxaOriginTrait.java", also by Matthew! Hence, thanks a lot, Matthew! ;-)
### Copyleft (or the one to blame): Carvalho, LMF (2014)

library(plotrix)
getStates <- function(rnames, fullnames) fullnames[as.numeric(sapply(rnames, function(s) grep(s, fullnames, ignore.case = TRUE)))]
plotJumpstbl <- function(tbl,  graphTitle, fullnames, groupLimit = .05, colour = "cadetblue"){
  noTrees <- sum(tbl[,1])
  column3 <- tbl[,1]/noTrees
  tbl <- cbind(tbl, column3)
  to.drop <- numeric(length = nrow(tbl))
  tbl <- cbind(tbl, to.drop)
  
  other.or.none.n <- 0
  other.or.none.d <- 0
  
  for(row in 1:nrow(tbl)){
    if(tbl[row, 2]<groupLimit){	
      other.or.none.n <- other.or.none.n + tbl[row, 1]
      other.or.none.d <- other.or.none.d + tbl[row, 2]
      tbl[row, 3] <- 1 
    }
  }
  
  tbl <- tbl[tbl[, 3]==0,]  
  tbl <- tbl[order(tbl[, 2]), ]  
  end.row <- c(other.or.none.n, other.or.none.d)
  tbl <- rbind(end.row,tbl)
  rownames(tbl)[1] <- "Other"
  row.names(tbl) <- getStates(row.names(tbl), fullnames)
  
  pdf(paste("../FIGURES/PLOTS/Origins", graphTitle, ".pdf", sep = "")) 
  par(mar = c(5.1, 12, 4.1, 1.8))
  bp <- barplot(as.numeric(tbl[, 2]), names.arg = row.names(tbl), xlim = c(0, 1.1),
                horiz = TRUE, xaxt="n", cex.lab = 1.5, cex.axis = 1.5, cex.names = 1.5,
                las = 1, col = colour, xlab = "Posterior probability", ylab = "Origin of virus\n\n\n\n")
  print(bp)
  mtext(graphTitle, side = 3, at = getFigCtr()[1], line = 0.8, cex = 2)
  axis(1, seq(0, 1, by = 0.25), cex.axis = 1.5)
  text(tbl[, 2] + groupLimit, bp, round(as.numeric(tbl[, 2]), digits = 2), adj = 0, cex = 1.5)
	dev.off()		
}
states <- c("Argentina", "Bolivia", "Brazil", "Colombia", "Ecuador", "Paraguay", "Peru", "Venezuela", "Uruguay", "Multiple", "Other", "Root") 

### Serotype A

A_Arg2001 <- read.table("../DATA/BEAST_OUTPUT/A_Arg_2001.csv", row.names = 1, sep = ",", header = FALSE)
A_Bol2001 <- read.table("../DATA/BEAST_OUTPUT/A_Bol_2001.csv", row.names = 1, sep = ",", header = FALSE)
A_Bra2001 <- read.table("../DATA/BEAST_OUTPUT/A_Bra_2001.csv", row.names = 1, sep = ",", header = FALSE)
A_Uru2001 <- read.table("../DATA/BEAST_OUTPUT/A_Uru_2001.csv", row.names = 1, sep = ",", header = FALSE)
A_Ecu2002 <- read.table("../DATA/BEAST_OUTPUT/A_Ecu_2002.csv", row.names = 1, sep = ",", header = FALSE)
A_Col2008 <- read.table("../DATA/BEAST_OUTPUT/A_Col_2008.csv", row.names = 1, sep = ",", header = FALSE)


plotJumpstbl(A_Arg2001, graphTitle = "A Argentina 2001", fullnames = states)
plotJumpstbl(A_Bol2001, graphTitle = "A Bolivia 2001", fullnames = states)
plotJumpstbl(A_Bra2001, graphTitle = "A Brazil 2001", fullnames = states)
plotJumpstbl(A_Uru2001, graphTitle = "A Uruguay 2001", fullnames = states)
plotJumpstbl(A_Ecu2002, graphTitle = "A Ecuador 2002", fullnames = states)
plotJumpstbl(A_Col2008, graphTitle = "A Colombia 2008", fullnames = states)

### Serotype O

O_Ecu2002 <- read.table("../DATA/BEAST_OUTPUT/O_Ecu_2002.csv", row.names = 1, sep = ",", header = FALSE)
O_Col1994 <- read.table("../DATA/BEAST_OUTPUT/O_Col_1994.csv", row.names = 1, sep = ",", header = FALSE)
O_Ven2003 <- read.table("../DATA/BEAST_OUTPUT/O_Ven_2003.csv", row.names = 1, sep = ",", header = FALSE)
O_Per2004 <- read.table("../DATA/BEAST_OUTPUT/O_Per_2004.csv", row.names = 1, sep = ",", header = FALSE)

plotJumpstbl(O_Ecu2002, graphTitle = "O Ecuador 2002", fullnames = states, colour = "indianred")
plotJumpstbl(O_Col1994, graphTitle = "O Colombia 1994", fullnames = states, colour = "indianred")
plotJumpstbl(O_Ven2003, graphTitle = "O Venezuela 2003", fullnames = states, colour = "indianred")
plotJumpstbl(O_Per2004, graphTitle = "O Peru 2004", fullnames = states, colour = "indianred")
