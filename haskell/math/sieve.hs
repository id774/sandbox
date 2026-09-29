-- sieve.hs: Primes below 100 by the sieve of Eratosthenes
--
-- Description:
-- Print the primes below 100, sieved by filtering each prime's multiples out of the candidates.
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
--     runghc sieve.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

sieve :: [Int] -> [Int]
sieve [] = []
sieve (prime : rest) = prime : sieve [n | n <- rest, n `mod` prime /= 0]

main :: IO ()
main = putStrLn . unwords . map show $ sieve [2 .. 99]
