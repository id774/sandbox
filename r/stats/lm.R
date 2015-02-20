df <- read.csv("macbook_price.csv", sep="\t")
result <- lm(df$PRICE ~ df$DISPLAY + df$RETINA + df$CPU + df$CORE + df$MEM + df$SSD)
summary(result)

result = lm(df$PRICE ~ df$CPU + df$CORE + df$MEM + df$SSD)
summary(result)

step(result)
