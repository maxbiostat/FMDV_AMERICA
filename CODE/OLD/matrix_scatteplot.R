statesA<-c("Arg","Bol","Bra","Col","Ecu","Per","Uru","Ven")
statesO<-c("Arg","Bol","Bra","Col","Ecu","Par","Per","Uru","Ven")
KA<-length(statesA);nA<-KA^2
mA<-matrix(1:nA,ncol=KA);posA<-mA[lower.tri(mA)]
gridA<-expand.grid(statesA,statesA)[posA,]
# gridA<-subset(expand.grid(statesA,statesA)[posA,],Var1!=Var2)
#
KO<-length(statesO);nO<-KO^2
mO<-matrix(1:nO,ncol=KO);posO<-mO[lower.tri(mO)]  
gridO<-expand.grid(statesO,statesO)[posO,]
###
cols.A<-match(gridA$Var1,statesA)
matA<-read.csv("Dropbox/FMDV_AMERICA/DATA/matrices_downsampled_A2.csv",sep="\t")
cols.O<-match(gridO$Var1,statesO)
matO<-read.csv("Dropbox/FMDV_AMERICA/DATA/matrices_downsampled_O2.csv",sep="\t")
#
plot(matA,pch=16,col=cols.A);title("Serotype A")
plot(matO,pch=16,col=cols.O);title("Serotype O")
# Colors depict country of origin
library(flexmix)
KLA<-KLdiv(as.matrix(apply(matA,2,function (x) return(density(x)$y))))
KLO<-KLdiv(as.matrix(apply(matO,2,function (x) return(density(x)$y))))
# L1 and L2 norms of the log-transformed matrices
library(PET)
vec2mat<-function(v){
  N<-length(v)
  K<-(1+sqrt(1+4*length(v)))/2
  M<-matrix(0,K,K)
  M[lower.tri(M)]<-v[1:(N/2)]
  M[upper.tri(M)]<-v[((N/2)+1):N]
  return(M)
}
##
mA1<-log(vec2mat(matA[,1]));diag(mA1)<-0
mA2<-log(vec2mat(matA[,2]));diag(mA2)<-0
mA3<-log(vec2mat(matA[,3]));diag(mA3)<-0
mA4<-log(vec2mat(matA[,4]));diag(mA4)<-0
mA5<-log(vec2mat(matA[,5]));diag(mA5)<-0
mAl<-list(mA1,mA2,mA3,mA4,mA5)
#
mO1<-log(vec2mat(matO[,1]));diag(mO1)<-0
mO2<-log(vec2mat(matO[,2]));diag(mO2)<-0
mO3<-log(vec2mat(matO[,3]));diag(mO3)<-0
mO4<-log(vec2mat(matO[,4]));diag(mO4)<-0
mO5<-log(vec2mat(matO[,5]));diag(mO5)<-0
mOl<-list(mO1,mO2,mO3,mO4,mO5)
##
norm.comp<-function(ml,mode="L1"){
  K<-length(ml)
  M<-matrix(0,K,K)
  grid<-subset(expand.grid(1:K,1:K),Var1!=Var2)
  for (p in 1:nrow(grid)){
    M[grid[p,1],grid[p,2]]<-PET::norm(ml[[grid[p,1]]],ml[[grid[p,2]]],mode=mode)    
  }
return(M)}
#
norm.comp(mAl)
norm.comp(mOl)
library(fields)
image.plot(norm.comp(mAl),main="Serotype A")
image.plot(norm.comp(mOl),main="Serotype O")