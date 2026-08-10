-- Print each command line argument on its own line.

module Main where

import System

main = do args <- getArgs
          mapM_ (putStrLn) args
