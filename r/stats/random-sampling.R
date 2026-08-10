# 生活指導が厳しい医師の外来に通う1000人から100人を無作為抽出し，標本平均と標本標準偏差を求める．
mean(sample(x=rnorm(n=1000,mean=6.5, sd=1), size=100, replace=FALSE))
sd(sample(x=rnorm(n=1000,mean=6.5, sd=1), size=100, replace=FALSE))

# 生活指導の厳しくない医師の外来に通う1000人から100人を無作為抽出し，標本平均と標本標準偏差を求める．
mean(sample(x=rnorm(n=1000,mean=7.5, sd=1.5), size=100, replace=FALSE))
sd(sample(x=rnorm(n=1000,mean=7.5, sd=1.5), size=100, replace=FALSE))

