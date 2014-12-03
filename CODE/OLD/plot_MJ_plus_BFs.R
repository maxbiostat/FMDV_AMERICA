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
################################
BFs<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/BFs_A.txt",T))
k<-length(Countries)
M<-matrix(rep(0,k^2),ncol=k);colnames(M)<-rownames(M)<-Countries
for(p in 1:nrow(BFs)){
  i<-match(as.character(BFs$FROM[p]),Countries)
  j<-match(as.character(BFs$TO[p]),Countries)
M[i,j]<-1  
}
FT<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/FT_A.txt",TRUE))
fnb<-mat2listw(M,style="B")
plot.spatnett(SA,ws=BFs$BF,nb=fnb$neighbours,nets=FT$FROM-FT$TO,nbrk=4,coropleth=T,thck=T,title="Net migration rate")
