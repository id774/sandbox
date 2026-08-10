data(airquality)

write.csv(airquality, "airquality.csv",
          quote=TRUE, row.names=TRUE, sep=",")

airq<-airquality[,1:4]
airq.lm<-lm(Ozone~., airq)
summary(airq.lm)

airq.lm<-lm(Ozone~. - 1,airq)
summary(airq.lm)
