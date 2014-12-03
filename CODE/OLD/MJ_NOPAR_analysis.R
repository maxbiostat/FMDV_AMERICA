mj<-data.frame(read.table("~/Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/MJ_56_alt.csv",TRUE))
#########
# Border vs Non-Border analysis
borderA<-mj$RA[mj$BORDER==0]
NborderA<-mj$RA[mj$BORDER==1]
borderO<-mj$RO[mj$BORDER==0]
NborderO<-mj$RO[mj$BORDER==1]
quantile(borderA,probs=c(.025,.5,.975))
quantile(NborderA,probs=c(.025,.5,.975))
quantile(borderO,probs=c(.025,.5,.975))
quantile(NborderO,probs=c(.025,.5,.975))
#
# Probabilistic assessment
N<-100000
# assessing the accuracy of the approach: simulate from normals and see what Pr(B>NB)
#borderA<-rnorm(length(borderA))
#NborderA<-rnorm(length(NborderA))
#borderO<-rnorm(length(borderO))
#NborderO<-rnorm(length(NborderO))
results<-data.frame(matrix(NA,N,2));names(results)<-c("A","O")  
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