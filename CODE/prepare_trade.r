### This script will process the complete trade matrix from FAO (http://faostat.fao.org/) and output a cleaned data set
### Copyleft (or the one to blame): Carvalho, LMF (2017)
rawTM <- read.csv("../DATA/TRADE_DATA/raw/FAOSTAT_data_5-22-2017_TRADEMATRIX.csv")
summary(rawTM)

## Sometimes there are discrepancies between what country A says it exported to B and what B says it imported from A.
## We will regularise the data by just taking the maximum reported between the two countries
makeSquareMatrix <- function(x){
  nsq <- length(x)
  n <- sqrt(nsq)
  if(!n%%1==0) stop("x doesn't seem to be a linear square matrix")
  return(matrix(x, ncol = n, nrow = n, byrow = FALSE))
}
# test:
# GG <- expand.grid(1:10, 1:10)
# makeSquareMatrix(apply(GG, 1, function(x) paste(x[1], x[2], sep = "to")))
#
getTrade <- function(x, var, db){
  getAns <- function(R, type = c("export", "import")){
    if(type == "export"){
      sR <- subset(R, Element == "Export Quantity")
    }else{
      sR <- subset(R, Element == "Import Quantity")
    }
    if(nrow(sR) == 0){
      ans <- 0
    }else{
      ans <- sR$Value
    }
    return(ans)
  }
  RowA <- subset(db, Item == var & Reporter.Countries == paste(unlist(x[1])) & Partner.Countries == paste(unlist(x[2])))
  RowB <- subset(db, Item == var & Reporter.Countries == paste(unlist(x[2])) & Partner.Countries == paste(unlist(x[1])))
  ans1 <- getAns(RowA, type = "export")
  ans2 <- getAns(RowB, type = "import")
  ans <- max(ans1, ans2)
  return(ans)  
}
#
makeTrade <- function(grid, var, db){
  apply(grid, 1, getTrade, var = var, db = db)  
}
#
makeTradeArray <- function(db, var){
  years <- sort(unique(db$Year))
  countries <- as.character(sort(unique(db$Reporter.Countries)))
  fromToGrid <- expand.grid(countries, countries)
  names(fromToGrid) <- c("from", "to")
  J <- length(years)
  K <- length(countries)   
  out <- array(NA, dim = c(K, K, J))
  for (j in 1:J) out[,, j] <- makeSquareMatrix(
    makeTrade(grid = fromToGrid, var = var, db = subset(db, Year == years[j]))
    )
  dimnames(out) <- list(countryOrigin = countries, countryDest = countries, year = years)
  return(out)
}
#
exportTradeArray <- function(obj, name, out = "../DATA/TRADE_DATA/"){
  years <- dimnames(obj)$year
  for (y in years) write.csv(obj[,, y], row.names = TRUE,
                             file = paste(out, "tradeMatrix_", name, "_", y, ".csv", sep = "") )
}
################
## Now let's apply our functions to the data.
################

Cattle <- makeTradeArray(db = rawTM, var = "Cattle")
Goats <- makeTradeArray(db = rawTM, var = "Goats")
Pigs <- makeTradeArray(db = rawTM, var = "Pigs")
Sheep <- makeTradeArray(db = rawTM, var = "Sheep")
Horses <- makeTradeArray(db = rawTM, var = "Horses")

##### 
## Exporting
#####

exportTradeArray(obj = Cattle, name = "cattle")
exportTradeArray(obj = Goats, name = "goats")
exportTradeArray(obj = Pigs, name = "pigs")
exportTradeArray(obj = Sheep, name = "sheep")
exportTradeArray(obj = Horses, name = "horses")

## now some convenience for R users
save(Cattle, file = "../DATA/TRADE_DATA/tradeArray_Cattle.RData")
save(Goats, file = "../DATA/TRADE_DATA/tradeArray_Goats.RData")
save(Pigs, file = "../DATA/TRADE_DATA/tradeArray_Pigs.RData")
save(Sheep, file = "../DATA/TRADE_DATA/tradeArray_Sheep.RData")
save(Horses, file = "../DATA/TRADE_DATA/tradeArray_Horses.RData")
