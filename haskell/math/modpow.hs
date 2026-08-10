-- Print modular powers of fixed triples, each squared and halved by a recursion on the exponent.
-- Run: runghc modpow.hs

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
