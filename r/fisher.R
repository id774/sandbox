
# fisher.test()関数を使用して、2変数の独立性の検定を行ないます。

# テストデータを作成します。

data_travel <- matrix( c( 167, 185, 133, 115 ), nrow=2 )
colnames( data_travel ) <- c( "GWに国内旅行", "GWに海外旅行" )
rownames( data_travel ) <- c( "夏休みに国内旅行", "夏休みに海外旅行" )

data_travel

# fisher.test()関数を実行します。

fisher.test( data_travel )
