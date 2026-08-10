set.seed(1234)
intercept <- 102.385888
a <- 0.316514
b <- 0.021370
x <- rnorm(n=19, mean=166.84211, sd=5.90916)
y <- rnorm(n=19, mean=155.94737, sd=4.63649)
residual <- rnorm(n=19, mean=0, sd=2.15664)
z <- intercept + a*x + b*y + residual
data <- cbind(z, x, y)
head(data)

# Multi Regress
result = lm(z ~ x + y)
summary(result)

# Simple Regress
result = lm(z ~ x)
summary(result)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(x, z)
abline(result)
dev.off()
