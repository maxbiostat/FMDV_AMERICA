#trade data
# trade<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/DATA/TRADE_72.txt",TRUE))
# trade<-subset(trade,FROM!=TO)
# #Mj data
mj<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/MJ_56_alt.csv",TRUE))
# JA<-JO<-B<-rep(NA,)  
# for (j in 1:nrow(trade)){
#    JA[j]<-subset(subset(mj,FROM==trade$FROM[j]),TO==trade$TO[j])$JUMPA
#    JO[j]<-subset(subset(mj,FROM==trade$FROM[j]),TO==trade$TO[j])$JUMPO
#     B[j]<-subset(subset(mj,FROM==trade$FROM[j]),TO==trade$TO[j])$BORDER
# }  
# tab<-data.frame(scale(trade[,3:5]),scale(JA),scale(JO),B)
# m1<-glm(JO~cattle*sheep*pig*B,tab,family="gaussian")# no association at all.
# #########
# Border vs Non-Border analysis
borderA<-mj$BFA[mj$BORDER==0]
NborderA<-mj$BFA[mj$BORDER==1]
borderO<-mj$BFO[mj$BORDER==0]
NborderO<-mj$BFO[mj$BORDER==1]
quantile(borderA,probs=c(.025,.5,.975))
quantile(NborderA,probs=c(.025,.5,.975))
quantile(borderO,probs=c(.025,.5,.975))
quantile(NborderO,probs=c(.025,.5,.975))
#
# Probabilistic assessment
N<-20000
# assessing the accuracy of the approach: simulate from normals and see what Pr(B>NB)
#  borderA<-rnorm(length(borderA))
#  NborderA<-rnorm(length(NborderA))
#  borderO<-rnorm(length(borderO))
#  NborderO<-rnorm(length(NborderO))
results<-data.frame(matrix(NA,N,2));names(results)<-c("A","B")  
for (i in 1:N){
  cat("complete=",i/N*100,"%","\n")
  bA<-sample(borderA,1)
  bO<-sample(borderO,1)
  nA<-sample(NborderA,1)
  nO<-sample(NborderO,1)
results[i,1]<-as.numeric(bA>nA)
results[i,2]<-as.numeric(bO>nO)  
}
colMeans(results)