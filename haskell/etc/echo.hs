-- echo.hs: Print command line arguments
--
-- Description:
-- Print each command line argument on its own line.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc echo.hs <arg>...
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the System module
--

module Main where

import System

main = do args <- getArgs
          mapM_ (putStrLn) args
