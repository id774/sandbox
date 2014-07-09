
n = 1000
df = 1
shape = 1
shape1 = 1
shape2 = 1
rate = 10
df1 = 10
df2 = 20

draw <- function (x, image) {
  png(image, width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
  hist(x)
  dev.off()
}

x = runif(n, min=0, max=1)
draw(x, 'runif.png')
x = rnorm(n, mean=0, sd=1)
draw(x, 'rnorm.png')
x = rlnorm(n, meanlog = 0, sdlog = 1)
draw(x, 'rlnorm.png')
x = rlnorm(n, meanlog = 0, sdlog = 1)
draw(x, 'rlnorm.png')
x = rgamma(n, shape, rate = 1, scale = 1/rate)
draw(x, 'rgamma.png')
x = rbeta(n, shape1, shape2)
draw(x, 'rbeta.png')
x = rchisq(n, df, ncp=0)
draw(x, 'rchisq.png')
x = rt(n, df)
draw(x, 'rt.png')
x = rf(n, df1, df2)
draw(x, 'rf.png')
x = rcauchy(n, location = 0, scale = 1)
draw(x, 'rcauchy.png')
x = rcauchy(n, location = 0, scale = 1)
draw(x, 'rcauchy.png')
x = rexp(n, rate = 1)
draw(x, 'rexp.png')
x = rlogis(n, location = 0, scale = 1)
draw(x, 'rlogis.png')
x = rweibull(n, shape, scale = 1)
draw(x, 'rweibull.png')

