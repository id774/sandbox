dataflame <- read.table("input.txt", sep="\t")

write.table(dataflame, file="output.txt", quote=F, col.names=F, row.names=F, sep="\t")
