-- quicksort.hs: Quicksort of a fixed integer sequence
--
-- Description:
-- Sort a fixed list with the classic quicksort written as two list comprehensions.
--
-- Part of the basics cross-language exercise set: the input is fixed in the
-- source, and the output is the same as that of the same exercise in every
-- other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc quicksort.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (pivot : rest) =
  quicksort [x | x <- rest, x <= pivot] ++ [pivot] ++ quicksort [x | x <- rest, x > pivot]

main :: IO ()
main = putStrLn . unwords . map show $ quicksort [5, 3, 8, 4, 2, 7, 1, 10, 9, 6 :: Int]
