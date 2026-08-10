
# https://rdatamining.wordpress.com/2012/05/17/an-example-of-social-network-analysis-with-r-using-package-igraph/

load("termDocMatrix.rdata")
library(igraph)

termDocMatrix[5:10,1:20]
termDocMatrix[termDocMatrix>=1] <- 1

termMatrix <- termDocMatrix %*% t(termDocMatrix)
termMatrix[5:10,5:10]

g <- graph.adjacency(termMatrix, weighted=T, mode = "undirected")
g <- simplify(g)

V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)

# Make it Look Better
V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color <- rgb(0, 0, .2, .8)
V(g)$frame.color <- NA
egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam

# plot the graph in layout1
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(g, layout=layout1)
dev.off()
