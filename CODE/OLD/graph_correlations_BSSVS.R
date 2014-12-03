## Script to transform Bayes Factors obtained by BSSVS
## into graphs and analyze them using graph theory
# Copyleft (or the one to blame): Carvalho, LMF (2012)
# Last update: 15/01/2012
### WARNING: This code is a MESS, and I don't care a bit about it :0) It was written for my own purposes
# load files and create data.frame
BFs<-data.frame(matrix(NA,ncol=5,nrow=))
for (i in 1:5){
  BFs[,i]<-data.frame(read.table(paste("~/Dropbox/FMDV_AMERICA/RESULTS/SPACE/SS_BSSVS/SSA",i,".csv",sep=""),T,sep=";"))
}