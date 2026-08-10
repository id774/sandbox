png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(biOps)
frame()
set.seed(0)
par(mfcol=c(2, 3))
par(mar=c(0, 0, 1, 0))
data(logo)
source <- imagedata(logo[,,3])
NI <- nrow(source)
NJ <- ncol(source)
s <- ifelse(source < 128, -1, 1)
plot(imagedata((s + 1) / 2 * 255))
title("source", cex.main=1.0)

# add noise
y <- s * ((runif(length(s)) > 0.1) * 2 - 1)
plot(imagedata((y + 1) / 2 * 255))
title("y", cex.main=1.0)

doplot <- function(beta, eta, h) {
	x <- y
	repeat {
		energyDiff <- 0
		for (i in (1:NI)) {
			for (j in (1:NJ)) {
				energy <- function(xx) {
					result <- h * xx
					if (i > 1) {
						result <- result - beta * xx * x[i - 1,j]
					}
					if (i < NI) {
						result <- result - beta * xx * x[i + 1,j]
					}
					if (j > 1) {
						result <- result - beta * xx * x[i,j - 1]
					}
					if (j < NJ) {
						result <- result - beta * xx * x[i,j + 1]
					}
					result <- result - eta * xx * y[i,j]
					result
				}
				values <- c(x[i,j], x[i,j] * -1)
				energies <- energy(values)
				minEnergyIndex <- which(energies == min(energies))
				x[i,j] <- values[minEnergyIndex]
				energyDiff <- energyDiff + energies[minEnergyIndex] - energies[1]
			}
		}
		cat("difference of total energy");print(energyDiff)
		if (energyDiff == 0) {
			break
		}
	}
	restored = round(sum(s == x) / length(x) * 100, 1)
	plot(imagedata((x + 1) / 2 * 255))
	title(paste0("x (beta=", beta, " eta=", eta, " h=", h, ") ", restored, "%"), cex.main=1.0)
}

doplot(1.0, 2.1, 0)
doplot(1.0, 2.1, 1.5)
doplot(1.0, 2.1, -1.5)
doplot(5.0, 2.1, -1.5)
dev.off()
