trade <- data.frame(read.table("TRADE_72.txt",TRUE))
##
M_c<-matrix(trade$cattle,ncol=9);M_c
M_c<-abs(scale(M_c+1,center=F));diag(M_c)<-0
u<-upper.tri(M_c,diag=F)
l<-lower.tri(M_c, diag = FALSE)
pw_c<-c(M_c[l],M_c[u])
##
M_p<-matrix(trade$pig,ncol=9);M_p
M_p<-abs(scale(M_p+1,center=F))
pw_p<-c(M_p[l],M_p[u])
##
M_s<-matrix(trade$sheep,ncol=9);M_s
M_s<-abs(scale(M_s+1,center=F))
pw_s<-c(M_s[l],M_s[u])
##
plot(density(pw_c),lwd=2,xlab=expression(m[jk]),main="")
lines(density(pw_p),lwd=2,col=2)
lines(density(pw_s),lwd=2,col=3)
legend(x="topright",legend=c("Cattle","Pigs","Sheep"),col=1:3,lwd=rep(2,3))
##

#write.table(data.frame(matrix(signif(pw_c,3),ncol=56)),file="cattle_dens_56.txt",sep=" ",col.names=FALSE,row.names=FALSE)
#write.table(data.frame(matrix(signif(pw_p,3),ncol=56)),file="pig_dens_56.txt",sep=" ",col.names=FALSE,row.names=FALSE)
#write.table(data.frame(matrix(signif(pw_s,3),ncol=56)),file="sheep_dens_56.txt",sep=" ",col.names=FALSE,row.names=FALSE)