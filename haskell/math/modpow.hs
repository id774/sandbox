-- modpow.hs: Modular exponentiation of fixed triples by repeated squaring
--
-- Description:
-- Print modular powers of fixed triples, each squared and halved by a recursion on the exponent.
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
--     runghc modpow.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

cases :: [(Integer, Integer, Integer)]
cases = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

modpow :: Integer -> Integer -> Integer -> Integer
modpow _ 0 _ = 1
modpow base exponent modulus
  | even exponent = half * half `mod` modulus
  | otherwise = base * modpow base (exponent - 1) modulus `mod` modulus
  where
    half = modpow base (exponent `div` 2) modulus

main :: IO ()
main = mapM_ report cases
  where
    report (base, exponent, modulus) =
      putStrLn (unwords (map show [base, exponent, modulus, modpow base exponent modulus]))
