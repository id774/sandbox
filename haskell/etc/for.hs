-- for.hs: forM_ loop with an IORef accumulator
--
-- Description:
-- Iterate a list with forM_ and accumulate a sum through an IORef.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc for.hs
--
-- Requirements:
-- - GHC (runghc)
--

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
