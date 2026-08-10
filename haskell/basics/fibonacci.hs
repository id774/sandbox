-- Print the first 20 Fibonacci numbers from an infinite self-referential list.
-- Run: runghc fibonacci.hs

fibonacci :: [Integer]
fibonacci = 0 : 1 : zipWith (+) fibonacci (tail fibonacci)

main :: IO ()
main = putStrLn . unwords . map show $ take 20 fibonacci
