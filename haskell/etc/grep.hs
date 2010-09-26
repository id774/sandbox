module Main (main) where

import System
import IO
import Text.Regex

main :: IO ()
main = do args <- getArgs
          doGrep $ mkRegex (head args)

doGrep :: Regex -> IO ()
doGrep re = do cs <- getContents
               mapM_ (\line -> case matchRegex re line of
                   Just _ -> putStrLn line
                   Nothing -> return ()) $ lines cs
