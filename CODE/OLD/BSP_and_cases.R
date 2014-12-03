BSP<-data.frame(read.table("M:\\SKYRIDE_O.txt",TRUE,sep="\t"))
Cases<-data.frame(read.table("M:\\Cases_O.txt",TRUE,sep="\t"))
Cases$R<-log(Cases$R)
BSP$Mean<-log(BSP$Mean)
BSP$Upper<-log(BSP$Upper)
BSP$Lower<-log(BSP$Lower)
plot(BSP$Time,BSP$Mean,ylim=c(0,4.5),lwd=2,ylab="Number of Populations",xlab="Time",col=2,type="l",xlim=c(1990,2010))
polygon(c(BSP$Time,rev(BSP$Time)),c(BSP$Lower,rev(BSP$Upper)),col="skyblue",border="red")
lines(BSP$Time,BSP$Mean,ylim=c(0,30),lwd=2,ylab="Number of Populations",xlab="Time",col=1)
lines(Cases$YEAR,Cases$R,lwd=2,type="b",col="blue")

windows()

