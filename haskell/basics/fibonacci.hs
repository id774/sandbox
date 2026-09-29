-- fibonacci.hs: The first 20 Fibonacci numbers
--
-- Description:
-- Print the first 20 Fibonacci numbers from an infinite self-referential list.
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
--     runghc fibonacci.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

fibonacci :: [Integer]
fibonacci = 0 : 1 : zipWith (+) fibonacci (tail fibonacci)

main :: IO ()
main = putStrLn . unwords . map show $ take 20 fibonacci
