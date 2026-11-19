-- grep.hs: Print input lines matching a regular expression
--
-- Description:
-- Print the standard input lines that match a regular expression argument.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc grep.hs <regexp> < input
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the System and IO modules
-- - The regex-compat package, which provides Text.Regex
--

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
