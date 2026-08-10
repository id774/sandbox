-- Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.
-- Run: runghc matrix.hs

import Data.List (transpose)

type Matrix = [[Int]]

left :: Matrix
left = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]

right :: Matrix
right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]

multiply :: Matrix -> Matrix -> Matrix
multiply a b = [[sum (zipWith (*) row column) | column <- transpose b] | row <- a]

determinant :: Matrix -> Int
determinant [[a, b, c], [d, e, f], [g, h, i]] =
  a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)
determinant _ = error "determinant expects a 3x3 matrix"

main :: IO ()
main = do
  let product' = multiply left right
  mapM_ (putStrLn . unwords . map show) product'
  print (determinant product')
