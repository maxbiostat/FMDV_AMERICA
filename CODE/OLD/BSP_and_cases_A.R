BSP<-data.frame(read.table("Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE/skyride_Afrom2000.txt",TRUE,sep="\t"))
Cases<-data.frame(read.table("Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE//cases_FMD.txt",TRUE,sep="\t"))
Vac<-data.frame(read.table("Dropbox/FMDV_AMERICA/RESULTS/DATA4CODE//vac_FMD.txt",TRUE,sep="\t"))
Cases$A<-log(Cases$A+1)
BSP$Mean<-log(BSP$Mean)
BSP$Median<-log(BSP$Median)
BSP$Upper<-log(BSP$Upper)
BSP$Lower<-log(BSP$Lower)
plot(BSP$Time,BSP$Mean,ylim=c(0,10),lwd=2,ylab="Effective Population Size",xlab="Time",col="blue",type="l",xlim=c(1990,2008))
polygon(c(BSP$Time,rev(BSP$Time)),c(BSP$Lower,rev(BSP$Upper)),col="red",border="red")
lines(BSP$Time,BSP$Mean,lwd=2,ylab="Effective Population Size",xlab="Time",col=1)
lines(Cases$YEAR,Cases$A,lwd=2,type="b",col="green")
par(new=TRUE) 
plot(Vac$Year,Vac$Mean,lwd=2,type="b",pch=23,ann=FALSE,xaxt="n", yaxt="n",ylab="",col="blue")
axis(4) 
legend(x="topleft", bty="n", lty=c(1,1,1),lwd=c(2,2,2), col=c(1,3,"blue"), legend=c("Viral Populations","FMD Cases", "Vaccine Doses per head"),cex=.6)
#windows()
# bands<-BSP[,4:5]
# (p1 <- ggplot(BSP,aes(BSP$Time, BSP$Median))+
#    geom_line(data=bands)+
#    xlab("Time") +
#    ylab("Effective Population Size") +
#    ggtitle("Serotype A")+
#    geom_ribbon(data=BSP,aes(ymin=Lower,ymax=Upper),alpha=0.3))
