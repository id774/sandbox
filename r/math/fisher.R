# fisher.R: Fisher's exact test of two travel choices
#
# Description:
# Test the independence of two travel choices in a two by two table with
# fisher.test.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript fisher.R
#
# Requirements:
# - R
#

# fisher.test()関数を使用して、2変数の独立性の検定を行ないます。

# テストデータを作成します。

data_travel <- matrix( c( 167, 185, 133, 115 ), nrow=2 )
colnames( data_travel ) <- c( "GWに国内旅行", "GWに海外旅行" )
rownames( data_travel ) <- c( "夏休みに国内旅行", "夏休みに海外旅行" )

data_travel

# fisher.test()関数を実行します。

fisher.test( data_travel )
