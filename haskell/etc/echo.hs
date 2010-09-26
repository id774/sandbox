module Main where

import System

main = do args <- getArgs
          mapM_ (putStrLn) args
