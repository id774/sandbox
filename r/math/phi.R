dataflame <- read.table("input.txt", sep="\t", header=TRUE)

x <- ifelse(dataflame$Result=="失注",0,1)
y <- ifelse(dataflame$Classify=="Positive",1,0)

table(dataflame$Result, dataflame$Classify)
cor(x, y)
