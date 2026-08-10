-- Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion.
-- Run: runghc gcd_lcm.hs

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
