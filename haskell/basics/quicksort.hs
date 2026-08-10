-- Sort a fixed list with the classic quicksort written as two list comprehensions.
-- Run: runghc quicksort.hs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (pivot : rest) =
  quicksort [x | x <- rest, x <= pivot] ++ [pivot] ++ quicksort [x | x <- rest, x > pivot]

main :: IO ()
main = putStrLn . unwords . map show $ quicksort [5, 3, 8, 4, 2, 7, 1, 10, 9, 6 :: Int]
