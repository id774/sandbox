-- Print the primes below 100, sieved by filtering each prime's multiples out of the candidates.
-- Run: runghc sieve.hs

sieve :: [Int] -> [Int]
sieve [] = []
sieve (prime : rest) = prime : sieve [n | n <- rest, n `mod` prime /= 0]

main :: IO ()
main = putStrLn . unwords . map show $ sieve [2 .. 99]
