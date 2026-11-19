-- getchar.hs: Read two characters from unbuffered input
--
-- Description:
-- Read two characters from unbuffered standard input.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc getchar.hs
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the IO, Monad, and Char
--   modules
--

import IO
import Monad
import Char

main = do
       hSetBuffering stdin NoBuffering
       a <- getChar
       b <- getChar
       print a
       print b
