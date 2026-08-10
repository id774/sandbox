-- Iterate a list with forM_ and accumulate a sum through an IORef.

import Control.Monad    -- Required for forM_
import Data.IORef       -- Required for mutable references

main = do
  printList [1..5]    -- Print 1 through 5
  s <- getSum [6..10] -- Sum 6 through 10
  print s

printList ls = do
  forM_ ls $ \i -> do  -- For each element `i` of the list
    print i

getSum ls = do
  s <- newIORef 0         -- Initialize the accumulator
  forM_ ls $ \i -> do      -- For each element `i` of the list
    c <- readIORef s
    writeIORef s (c + i)  -- Update the running total
  ret <- readIORef s      -- Read the final total
  return ret              -- Return it
