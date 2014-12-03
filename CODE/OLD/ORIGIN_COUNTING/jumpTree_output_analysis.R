library(plotrix)

prettyLabels <- function(labels){
  labels <- gsub("_", " ", labels)
  labels <- gsub("EP12A", "Egypt/Palestine 2012 (Alx-12)", labels)
  labels <- gsub("EP12", "Egypt/Palestine 2012 (Ghb-12)", labels)
  labels <- gsub("Libya12", "Libya 2012", labels)
  labels <- gsub("Libya03", "Libya 2003", labels)
  labels <- gsub("Bahrain", "Bahrain 2012", labels)
  labels <- gsub("Saudi Arabia", "Saudi Arabia 2000", labels)
  labels <- gsub("North Yemen", "North Yemen 1990", labels)
}

shortLabels <- function(labels){
  labels <- gsub("_", " ", labels)
  labels <- gsub("EP12A", "E/P 2012 (Alx-12)", labels)
  labels <- gsub("EP12", "E/P 2012 (Ghb-12)", labels)
  labels <- gsub("Libya12", "Libya 2012", labels)
  labels <- gsub("Libya03", "Libya 2003", labels)
  labels <- gsub("Bahrain", "Bahrain 2012", labels)
  labels <- gsub("Saudi Arabia", "Saudi Arabia\n2000", labels)
  labels <- gsub("North Yemen", "North Yemen 1990", labels)
}

processFiles <- function(path, rootName, endName, outName, state, groupLimit){
	tbl <- read.table(paste(path, rootName, state, endName, sep = ""), row.names = 1, sep = ",", skip = 1, header = FALSE)
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
		
	tbl <- tbl[order(tbl[, 2]),]
	
	end.row <- c(other.or.none.n, other.or.none.d)
	
	tbl <- rbind(end.row,tbl)
	
	rownames(tbl)[1] <- "Other"

	graphTitle <- prettyLabels(state)
	row.names(tbl) <- shortLabels(row.names(tbl))
# svg(f)	
	par(mar = c(5.1, 12, 4.1, 1.8))
	bp <- barplot(as.numeric(tbl[, 2]), names.arg = row.names(tbl), xlim = c(0, 1.1),
                horiz = TRUE, xaxt="n", cex.lab = 1.5, cex.axis = 1.5, cex.names = 1.5,
                las = 1, col = "cadetblue", xlab = "Posterior probability", ylab = "Origin of virus\n\n\n\n")
  print(bp)
	mtext(graphTitle, side=3, at = getFigCtr()[1], line = 0.8, cex = 2)
	axis(1, seq(0, 1, by = 0.25), cex.axis = 1.5)
	text(tbl[, 2]+0.02, bp, round(as.numeric(tbl[, 2]), digits = 2), adj = 0, cex = 1.5)
# 	dev.off()		
}
states.of.interest <- c("Bahrain", "EP12", "EP12A", "Libya03", "Libya12", "North_Yemen", "Saudi_Arabia")
youngest.tip <- 2012
path <- "/Users/mhall/Documents/FMD global/VP1/Type SAT 2 VP1/Final rush/SAT2_VP1_250_countries_asym_emptrees_MJ/"
rootName <- "SAT2_VP1_250_countries_asym_emptrees_MJ_"
endName <- ".csv"
outName <- "origins"
groupLimit <- 0.02
for(outbreak in 1:length(states.of.interest)){
	processFiles(path, rootName, endName, outName, states.of.interest[outbreak], groupLimit)
}