regulariseNames <- function(mat){
  Names <- gsub(" \\(Bolivarian Republic of\\)",
                "", gsub(" \\(Plurinational State of\\)", "", colnames(mat)) )
  colnames(mat) <- rownames(mat) <- Names
  return(mat)
}
AggByPeriod <- function(trade, period){
  sepString <- strsplit(period, "-")
  init <- as.numeric(sepString[[1]][1])
  end <-   as.numeric(sepString[[1]][2])
  
  numYears <- as.numeric(dimnames(trade)$year)
  pos <- intersect(which(numYears > init), which(numYears <= end))
  mat <- apply(trade[, , pos], c(1,2), sum)
  return(regulariseNames(mat))
}
flatten <- function(mat, name){
  grid <- expand.grid(colnames(mat), row.names(mat))
  out <- data.frame(grid, x = as.vector(mat))
  names(out) <- c("from", "to", name)
  return(out)
}
exportAggregated <- function(dt){
  write.csv(dt,
            file = paste("../DATA/TRADE_DATA/", names(dt)[3], ".csv", sep = ""),
            row.names = FALSE)
}
################
load("../DATA/TRADE_DATA/tradeArray_Cattle.RData")
load("../DATA/TRADE_DATA/tradeArray_Sheep.RData")
load("../DATA/TRADE_DATA/tradeArray_Pigs.RData")

Periods <- c("1986-1995", "1995-2004", "2004-2013")

CattleByPeriod <- lapply(Periods, AggByPeriod, trade = Cattle)
SheepByPeriod <- lapply(Periods, AggByPeriod, trade = Sheep)
PigsByPeriod <- lapply(Periods, AggByPeriod, trade = Pigs)

names(CattleByPeriod) <- names(SheepByPeriod)  <- names(PigsByPeriod) <- Periods
#
CattleDfs <- lapply(seq_along(CattleByPeriod), function(index){
  flatten(mat = CattleByPeriod[[index]],
          name = paste("cattleTrade_", names(CattleByPeriod)[index], sep = ""))
} )
#
SheepDfs <- lapply(seq_along(SheepByPeriod), function(index){
  flatten(mat = SheepByPeriod[[index]],
          name = paste("sheepTrade_", names(SheepByPeriod)[index], sep = ""))
} )
#
PigsDfs <- lapply(seq_along(PigsByPeriod), function(index){
  flatten(mat = PigsByPeriod[[index]],
          name = paste("pigsTrade_", names(PigsByPeriod)[index], sep = ""))
} )
##
lapply(CattleDfs, exportAggregated)
lapply(SheepDfs, exportAggregated)
lapply(PigsDfs, exportAggregated)

AllCattle <- Reduce(function(...) merge(..., all = TRUE), CattleDfs)
AllSheep <- Reduce(function(...) merge(..., all = TRUE), SheepDfs)
AllPigs <- Reduce(function(...) merge(..., all = TRUE), PigsDfs)

AllTrades <- Reduce(function(...) merge(..., all = TRUE), list(AllCattle, AllSheep, AllPigs))
write.csv(AllTrades, file = "../DATA/TRADE_DATA/all_trade_by_period.csv" ,  row.names = FALSE)
# fields::image.plot(cor(log( AllTrades [, -c(1, 2)]+ 1)))
