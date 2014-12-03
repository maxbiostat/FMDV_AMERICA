source("spatnet_aux.R")
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
fmat<-matrix(rep(1,length(SA)^2),ncol=length(SA));diag(fmat)<-0;rownames(fmat)<-colnames(fmat)<-Countries
fmat[upper.tri(fmat)]<-0
fnb<-mat2listw(fmat,style="B")
tmat<-matrix(rep(1,length(SA)^2),ncol=length(SA));diag(tmat)<-0;rownames(tmat)<-colnames(tmat)<-Countries
tmat[lower.tri(tmat)]<-0
tnb<-mat2listw(tmat,style="B")
mjtable<-data.frame(read.table("E:\\MJ\\MJ_72.txt",TRUE))
FT<-data.frame(read.table("E:\\MJ\\FT_A.txt",TRUE))
M<-vec2sqmat(mjtable$JUMPA)
colnames(M)<-rownames(M)<-Countries
M
#par(mar=c(0,0,0,0))
#par(mfrow=c(1,2))
plot.spatnett(SA,ws=mjtable$JUMPA,nb=fnb$neighbours,nets=FT$FROM-FT$TO,nbrk=5,coropleth=F,thck=T,title="Net migration rate")
title("A")
plot.spatnett(SA,ws=rev(mjtable$JUMPA),nb=tnb$neighbours,nets=FT$FROM-FT$TO,nbrk=5,coropleth=F,thck=T,title="Net migration rate")
title("B")
####