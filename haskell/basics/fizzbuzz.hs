-- fizzbuzz.hs: FizzBuzz for 1 through 100
--
-- Description:
-- Print FizzBuzz for 1 through 100, choosing the label with guards over the remainders.
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
--     runghc fizzbuzz.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

label :: Int -> String
label n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n

main :: IO ()
main = mapM_ (putStrLn . label) [1 .. 100]
