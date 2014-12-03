### Little script to process data from the FAO detailed trade matrix on livestock commerce
### This will get the whole database and mount the matrices we used in the predictors analyses
### Copyleft (or the one to blame): Carvalho, LMF (2014)
### Last update: 30/11/2014
raw <- data.frame(read.table("database_trade.txt", header = TRUE))
Locations <- c("Argentina", "Brazil", "Bolivia", "Colombia",
               "Ecuador", "Paraguay", "Peru", "Uruguay", "Venezuela")
l <- as.factor(Locations)
imp <- subset(subset(raw, FLUX == "Import"), TO == Locations)
exp <- subset(subset(raw, FLUX == "Export"), TO == Locations)
grid <- expand.grid(Locations, Locations); names(grid)<-c("FROM", "TO"); gridb <- grid
#########################
FROM <- as.factor(c(as.character(imp$TO), as.character(exp$FROM)))
TO <- as.factor(c(as.character(imp$FROM), as.character(exp$TO)))
Cattle <- c(imp$Cattle, exp$Cattle)
Sheep <- c(imp$Sheep, exp$Sheep)
Pig <- c(imp$Pig, exp$Pig)
D <- data.frame(FROM, TO, Cattle, Sheep, Pig)
#
#Cattle=1
#Sheep=2
#Pig=3
cattle<-vector()
 for(i in 1:nrow(grid)){
  corresp <- subset(subset(D, FROM == paste(grid[i,1])), TO == paste(grid[i,2]))
   if(dim(corresp)[1] > 0){
    cattle[i] <- as.numeric(colSums(corresp[, 3:5][1]))
   }
   else
    cattle[i] <- 0
 }
cattle
####
pig<-vector()
 for(i in 1:nrow(grid)){
  corresp <- subset(subset(D, FROM == paste(grid[i,1])), TO == paste(grid[i,2]))
   if(dim(corresp)[1] > 0){
    pig[i] <- as.numeric(colSums(corresp[, 3:5][3]))
   }
   else
    pig[i] <- 0
 }
pig
####
sheep<-vector()
 for(i in 1:nrow(grid)){
  corresp <- subset(subset(D, FROM == paste(grid[i,1])), TO == paste(grid[i,2]))
   if(dim(corresp)[1] > 0){
    sheep[i] <- as.numeric(colSums(corresp[, 3:5][2]))
   }
   else
    sheep[i] <- 0
 }
sheep
trade <- data.frame(cattle, sheep, pig)
tradec <- data.frame(grid, cattle, sheep, pig)
#write.table(tradec, file = "TRADE.txt", sep = "\t")