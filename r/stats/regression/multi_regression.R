df = read.csv("sample_data.csv")

row.names(df) = df[,1]
df = df[,2:4]
head(df)

a <- df[,1]
b <- df[,2]
y <- df[,3]

result = lm(y ~ a + b)
summary(result)
