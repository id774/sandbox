-- collatz.hs: Longest Collatz sequence for a start below 1000
--
-- Description:
-- Print the start below 1000 with the longest Collatz sequence, picked by maximumBy over a lazy list.
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
--     runghc collatz.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

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
