
UKgas
str(UKgas)

# 折れ線グラフを描いて確認
plot(UKgas,xlab="四半期",ylab="ガス使用量")
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

# データに含まれる規則性（周期性）成分と、それ以外の成分（上昇トレンドと誤差）に分けてみる
plot(stl(UKgas,s.window="periodic"),main="UKgasデータの成分分解", cex.main=2.5)
png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

# "trend"(トレンド)欄から、季節変動成分と誤差成分("reminder")を除く
# 時間の経過とともに定常的に上昇している傾向が浮かび上がっている
par(mfrow=c(2,1))
plot(window(UKgas, start=1980, end=1983),xlab="四半期",ylab="ガス使用量")
plot(window(UKgas, start=1980, end=1982),xlab="四半期",ylab="ガス使用量")
png("image3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

# 自己相関をみて、何期離れた期間との相関関係が強いかを洗い出し
acf(UKgas)

# 上昇トレンド除去
plot(diff(UKgas),xlab="四半期",ylab="ガス使用量",main="UKgas\n１階の差分系列")
png("image4.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
diff.UKgas <- diff(UKgas)

# データが「NGデータではないための条件」（＝定常性の条件）を満たしているかを確認
#install.packages("tseries")
library(tseries)
# P 値 0.01 以下
adf.test(diff.UKgas)
# 元データは P 値 0.01 より大きい
adf.test(UKgas)

# ここまでのデータ加工作業で、データはNGデータではない状態に加工できた

# 対数変換 (時間の経過に伴い上下の変動幅が増幅してるから)
plot(log(UKgas),xlab="四半期",ylab="ガス使用量",main="UKgas\n対数変換系列")
png("image5.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

# トレンド成分を除去するために、１回の差分をとる
plot(diff(log(UKgas)),xlab="四半期",ylab="ガス使用量",main="UKgas\n対数変換+１階差分 系列")
png("image6.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
diff_log_UKgas <- diff(log(UKgas))
adf.test(diff_log_UKgas)

# 季節調整(1年周期＝4（四半）期)をとる
#install.packages("TTR")
library(TTR)
plot(SMA(UKgas, n=4))
png("image7.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

# 加工した1階差分（トレンド除去）＋対数変換（上下変動幅縮小）データに4期の季節調整をとる
plot(SMA(diff_log_UKgas, n=4))
SMA_diff_log_UKgas <- SMA(diff_log_UKgas)
plot(SMA_diff_log_UKgas, n=4)
png("image8.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

