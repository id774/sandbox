import Control.Monad    -- for文を使うときに必要
import Data.IORef       -- 変数を使うときに必要

main = do
  printList [1..5]    -- 1から5まで標準出力
  s <- getSum [6..10] -- 6から10までの総和を求める
  print s

printList ls = do
  forM_ ls $ \i -> do  -- リスト内の各要素`i`について
    print i

getSum ls = do
  s <- newIORef 0         -- 総和を保存するための変数を初期化
  forM_ ls $ \i -> do      -- リスト内の各要素`i`について
    c <- readIORef s
    writeIORef s (c + i)  -- 総和を更新
  ret <- readIORef s      -- 最終的な総和を取得して
  return ret              -- 返り値にする
