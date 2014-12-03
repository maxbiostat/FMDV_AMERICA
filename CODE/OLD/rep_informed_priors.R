###  Correction weights for trade/distance-informed priors
# Serotype A
tab_a<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/DATA/BANCO/rep_A.txt",TRUE))
gridA<-expand.grid(tab_a$COUNTRY,tab_a$COUNTRY)
diffsa<-rep(NA,nrow(gridA))
for (p in 1:nrow(gridA)){
  pos1<-match(gridA[p,1],tab_a$COUNTRY)
  pos2<-match(gridA[p,2],tab_a$COUNTRY)
  diffsa[p]<-abs(tab_a$REP[pos1]-tab_a$REP[pos2])
}
tabdiffA<-cbind(gridA,DIFF=diffsa);head(tabdiffA)
M_A<-matrix(diffsa,ncol=8,nrow=8);colnames(M_A)<-tab_a$COUNTRY;rownames(M_A)<-tab_a$COUNTRY
ua<-upper.tri(M_A,diag=F)
la<-lower.tri(M_A, diag = FALSE)
pw_A<-c(M_A[la],M_A[ua]);hist(pw_A)
nA<-abs(scale(1/pw_A,center=F))
#
hist(1/pw_A,main="Serotype A before Normalization")
hist(nA,main="Serotype A after Normalization")
#######
# Serotype O
#######
tab_o<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/DATA/BANCO/rep_O.txt",TRUE))
gridO<-expand.grid(tab_o$COUNTRY,tab_o$COUNTRY)
diffso<-rep(NA,nrow(gridO))
for (i in 1:nrow(gridO)){
  pos1<-match(gridO[i,1],tab_o$COUNTRY)
  pos2<-match(gridO[i,2],tab_o$COUNTRY)
  diffso[i]<-abs(tab_o$REP[pos1]-tab_o$REP[pos2])
}
tabdiffO<-cbind(gridO,DIFF=diffso);head(tabdiffO)
M_O<-matrix(diffso,ncol=9,nrow=9);colnames(M_O)<-tab_o$COUNTRY;rownames(M_O)<-tab_o$COUNTRY
uo<-upper.tri(M_O,diag=F)
lo<-lower.tri(M_O, diag = FALSE)
pw_O<-c(M_O[lo],M_O[uo]);hist(pw_O)
library(fields);image.plot(M_O,main="Serotype O before Normalization");image.plot(M_O,main="Serotype O after Normalization")
