-- Print the start below 1000 with the longest Collatz sequence, picked by maximumBy over a lazy list.
-- Run: runghc collatz.hs

import Data.List (maximumBy)
import Data.Ord (comparing)

step :: Int -> Int
step n = if even n then n `div` 2 else n * 3 + 1

chainLength :: Int -> Int
chainLength = length . takeWhile (/= 1) . iterate step

main :: IO ()
main = putStrLn (unwords (map show [longest, chainLength longest + 1]))
  where
    longest = maximumBy (comparing chainLength) [1 .. 999]
