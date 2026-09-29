-- gcd_lcm.hs: GCD and LCM of fixed pairs by Euclid's algorithm
--
-- Description:
-- Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion.
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
--     runghc gcd_lcm.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

pairs :: [(Int, Int)]
pairs = [(1071, 462), (270, 192), (17, 5), (120, 36)]

euclid :: Int -> Int -> Int
euclid first 0 = first
euclid first second = euclid second (first `mod` second)

report :: (Int, Int) -> String
report (first, second) =
  unwords (map show [first, second, divisor, first `div` divisor * second])
  where
    divisor = euclid first second

main :: IO ()
main = mapM_ (putStrLn . report) pairs
