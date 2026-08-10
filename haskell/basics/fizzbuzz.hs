-- Print FizzBuzz for 1 through 100, choosing the label with guards over the remainders.
-- Run: runghc fizzbuzz.hs

label :: Int -> String
label n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n

main :: IO ()
main = mapM_ (putStrLn . label) [1 .. 100]
