-- matrix.hs: Product and determinant of two fixed 3x3 integer matrices
--
-- Description:
-- Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.
--
-- Part of the math cross-language exercise set: it reads no arguments or
-- standard input, keeps its data fixed in the source, uses integer
-- arithmetic only, and its output is the same as that of the same exercise
-- in every other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc matrix.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

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
