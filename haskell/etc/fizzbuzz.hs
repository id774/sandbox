-- fizzbuzz.hs: FizzBuzz up to a count from standard input
--
-- Description:
-- Print FizzBuzz up to a count read from standard input.
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
-- - GHC (runghc)
--

import Control.Monad

main = do
  putStrLn "いくつまで？: "
  numStr <- getLine       -- Read the number as a string
  let num = read numStr   -- `read` converts a string to a number
  fizzBuzz num

fizzBuzz num = do
  forM_ [1..num] $ \i -> do
    putStrLn (show i ++ ": " ++ toFizzBuzz i)

toFizzBuzz num =
  case mod num 15 of    -- `mod` returns the remainder
    0 -> "FizzBuzz"
    3 -> "Fizz"
    5 -> "Buzz"
    6 -> "Fizz"
    9 -> "Fizz"
    10 -> "Buzz"
    12 -> "Fizz"
    _ -> ""
