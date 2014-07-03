year=1978:2009
total=c(20788,21503,21048,20434,21228,25202,24596,23599,
  25524,24460,23742,22436,21346,21084,22104,21851,21679,
  22445,23104,24391,32863,33048,31957,31042,32143,34427,
  32325,32552,32155,33093,32249,32845)
par(las=1)
par(mgp=c(2,0.8,0))
plot(year, total, type="o", pch=16, xlab="", ylab="",
     ylim=c(19000,35000), axes=FALSE,
     col="royalblue3", lwd=2)
t=c(1978,seq(1985,2005,5),2009)
u=t; u[1]="1978"
axis(1,t,u)
t=seq(20000,35000,5000)
axis(2,t,t/10000)
axis(2,"1/10000",at=35000,padj=-1,tick=FALSE)
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
