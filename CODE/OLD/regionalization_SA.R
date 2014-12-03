# Loading
source("Dropbox/FMDV_AMERICA/CODE//spatnet_aux.R")
data(wrld_simpl)
world<-wrld_simpl
Countries<-c("Argentina","Bolivia","Brazil","Colombia","Ecuador",
             "Paraguay","Peru","Uruguay","Venezuela")
which.polys<-vector(mode="list",length(Countries))
for (c in 1:length(Countries)){
  which.polys[[c]]<-grep(paste(Countries[c]),world$NAME)
}
SA<-world[unlist(which.polys),]
datum<-data.frame(read.table("Dropbox/FMDV_AMERICA/DATA/data_FMD_reg.txt",TRUE))
cont<-as.matrix(read.table("Dropbox/FMDV_AMERICA/DATA/contiguity_SA.txt"))
SA.nb<-mat2listw(cont,style="B")$neighbours
plot(SA)
plot(SA.nb,coordinates(SA),add=T,col=2,lwd=2)
### 
# Regionalization
#vac<-datum[,2:6]
#cases_A<-datum[,7:8]
#cases_O<-datum[,9:10]
#cattle_pop<-datum[,11:13]
dataR<-datum[,2:10]#datum[,2:28]
lcosts <- nbcosts(SA.nb, dataR)
nb.w <- nb2listw(SA.nb, lcosts, style="B")
mst.SA <- mstree(nb.w,5)
#reg <- skater(mst.SA[,1:2], dataR, 2,c(2,5), rep(1,nrow(SA@data)))
reg <- skater(mst.SA[,1:2], dataR, 2,c(2,5), rep(1,nrow(SA@data)),method="mahalanobis",cov=cov(dataR,use="complete.obs"))
plot(SA, col=reg$groups+1);title("Cases and Vaccination")
