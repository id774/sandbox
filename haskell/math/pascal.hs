-- Print 10 rows of Pascal's triangle, taken from the infinite list each row of which zips the one before.
-- Run: runghc pascal.hs

rows :: [[Integer]]
rows = iterate next [1]
  where
    next row = zipWith (+) (0 : row) (row ++ [0])

main :: IO ()
main = mapM_ (putStrLn . unwords . map show) (take 10 rows)
