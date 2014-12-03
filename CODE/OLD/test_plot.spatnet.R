source("~/Dropbox/FMDV_AMERICA/CODE/spatnet_aux.R")
library(maptools);library(spdep);library(RColorBrewer)
data(wrld_simpl)
world<-wrld_simpl
Countries<-c("Argentina","Bolivia","Brazil","Colombia","Ecuador",
             "Paraguay","Peru","Uruguay","Venezuela")
which.polys<-vector(mode="list",length(Countries))
for (c in 1:length(Countries)){
  which.polys[[c]]<-grep(paste(Countries[c]),world$NAME)
}
SA<-world[unlist(which.polys),]
################################
map<-SA
states<-Countries
g<-subset(expand.grid(states,states),Var1!=Var2)
#mjtable<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/A_mjtable.txt",TRUE))#data.frame(g,JUMP=rpois(nrow(g),l=2));names(mjtable)<-c("FROM","TO","JUMP")
M<-vec2sqmat(trade$pig);colnames(M)<-rownames(M)<-Countries
#FT<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/FT_A.txt",TRUE))
par(mfrow=c(2,2))
r<-range(M/max(M))
for(s in seq(r[1],r[2],(r[2]-r[1]) /5)){
plot.spatnet(map,nmat=M,s=s,net=TRUE,dir="to",brk=4)
}