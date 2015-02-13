library("pequod")

data <- read.csv("sample_data2.csv")

# 2 要因の回帰分析
# 従属変数は sat 独立変数は talk 調整変数は per
model1 <- lmres(sat~talk*per, centered =c("talk", "per"), data=data)
summary(model1)

# 単純主効果,m
model2 <- simpleSlope(model1, pred="talk", mod1 = "per")
summary(model2)

# per が高群（+1SD) の場合に talk の効果
# 低群 (-1SD) の場合，有意ではない

PlotSlope(model2)

# 交互作用項が二つ以上でも単純主効果の分析
model3 <- lmres(sat~talk*per*con,centered=c("talk","per","con"),data=data)
summary(model3)

# 単純効果の検定
model4 <- simpleSlope(model3, pred="talk", mod1 = "per", mod2="con")
summary(model4)
